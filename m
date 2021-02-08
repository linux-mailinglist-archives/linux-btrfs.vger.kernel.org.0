Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFAB3142C8
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Feb 2021 23:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhBHWWl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Feb 2021 17:22:41 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:44782 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhBHWWi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Feb 2021 17:22:38 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id F298B976C86; Mon,  8 Feb 2021 17:21:54 -0500 (EST)
Date:   Mon, 8 Feb 2021 17:21:54 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     kreijack@inwind.it
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: is BTRFS_IOC_DEFRAG behavior optimal?
Message-ID: <20210208222154.GD32440@hungrycats.org>
References: <CAJCQCtSx=HcCRMiE0eganPWJVTB+b4zfb_mnd68L2VapGGKi7Q@mail.gmail.com>
 <3897f126-e977-d842-f91d-b48b74958f3d@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3897f126-e977-d842-f91d-b48b74958f3d@libero.it>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 08, 2021 at 11:11:47PM +0100, Goffredo Baroncelli wrote:
> On 2/7/21 11:06 PM, Chris Murphy wrote:
> > systemd-journald journals on Btrfs default to nodatacow,  upon log
> > rotation it's submitted for defragmenting with BTRFS_IOC_DEFRAG. The
> > result looks curious. I can't tell what the logic is from the results.
> > 
> > The journal file starts out being fallocated with a size of 8MB, and
> > as it grows there is an append of 8MB increments, also fallocated.
> > This leads to a filefrag -v that looks like this (ext4 and btrfs
> > nodatacow follow the same behavior, both are provided for reference):
> > 
> > ext4
> > https://pastebin.com/6vuufwXt
> > 
> > btrfs
> > https://pastebin.com/Y18B2m4h
> > 
> > Following defragment with BTRFS_IOC_DEFRAG it looks like this:
> > https://pastebin.com/1ufErVMs
> > 
> > It appears at first glance to be significantly more fragmented. Closer
> > inspection shows that most of the extents weren't relocated. But
> > what's up with the peculiar interleaving? Is this an improvement over
> > the original allocation?
> 
> I am not sure how read the filefrag output: I see several lines like
> [...]
>    5:     1691..    1693:     125477..    125479:      3:
>    6:     1694..    1694:     125480..    125480:      1:             unwritten
> [...]
> 
> What means "unwritten" ? The kernel documentation [*] says:
> [...]
> * FIEMAP_EXTENT_UNWRITTEN
> Unwritten extent - the extent is allocated but its data has not been
> initialized.  This indicates the extent's data will be all zero if read
> through the filesystem but the contents are undefined if read directly from
> the device.
> [..]
> So it seems that the data didn't touch the platters (!)
> 
> My educate guess is that there is something strange in the sequence:
> - write
> - sync
> - close log
> - move log
> - defrag log
> 
> May be the defrag starts before all the data reach the platters ?

defrag will put the file's contents back into delalloc, and it won't be
allocated until a flush (fsync, sync, or commit interval).  Defrag is
roughly equivalent to simply copying the data to a new file in btrfs,
except the logical extents are atomically updated to point to the new
location.

FIEMAP has an option flag to sync the data before returning a map.
DEFRAG has an option to start IO immediately so it will presumably be
done by the time you look at the extents with FIEMAP.

> For what matters, I create a file with the same fragmentation like your one
> 
> $ sudo filefrag -v data.txt
> Filesystem type is: 9123683e
> File size of data.txt is 25165824 (6144 blocks of 4096 bytes)
>  ext:     logical_offset:        physical_offset: length:   expected: flags:
>    0:        0..       0:    1597171..   1597171:      1:
>    1:        1..    1599:  163433285.. 163434883:   1599:    1597172:
>    2:     1600..    1607:    1601255..   1601262:      8:  163434884:
>    3:     1608..    1689:    1604137..   1604218:     82:    1601263:
>    4:     1690..    1690:    1597484..   1597484:      1:    1604219:
>    5:     1691..    1693:    1597465..   1597467:      3:    1597485:
>    6:     1694..    1694:    1597966..   1597966:      1:    1597468:
>    7:     1695..    1722:    1599557..   1599584:     28:    1597967:
>    8:     1723..    1723:    1599211..   1599211:      1:    1599585:
>    9:     1724..    1955:    1648394..   1648625:    232:    1599212:
>   10:     1956..    1956:    1599695..   1599695:      1:    1648626:
>   11:     1957..    2047:    1625881..   1625971:     91:    1599696:
>   12:     2048..    2417:    1648804..   1649173:    370:    1625972:
>   13:     2418..    2420:    1597468..   1597470:      3:    1649174:
>   14:     2421..    2478:    1624667..   1624724:     58:    1597471:
>   15:     2479..    2479:    1596416..   1596416:      1:    1624725:
>   16:     2480..    2482:    1601045..   1601047:      3:    1596417:
>   17:     2483..    2483:    1596854..   1596854:      1:    1601048:
>   18:     2484..    2523:    1602715..   1602754:     40:    1596855:
>   19:     2524..    2527:    1597471..   1597474:      4:    1602755:
>   20:     2528..    2598:    1624725..   1624795:     71:    1597475:
>   21:     2599..    2599:    1596858..   1596858:      1:    1624796:
>   22:     2600..    2607:    1601263..   1601270:      8:    1596859:
>   23:     2608..    2608:    1596863..   1596863:      1:    1601271:
>   24:     2609..    2611:    1601271..   1601273:      3:    1596864:
>   25:     2612..    2612:    1596864..   1596864:      1:    1601274:
>   26:     2613..    2615:    1601274..   1601276:      3:    1596865:
>   27:     2616..    2616:    1596981..   1596981:      1:    1601277:
>   28:     2617..    2691:    1649174..   1649248:     75:    1596982:
>   29:     2692..    2696:    1597475..   1597479:      5:    1649249:
>   30:     2697..    2756:    1634995..   1635054:     60:    1597480:
>   31:     2757..    2758:    1597480..   1597481:      2:    1635055:
>   32:     2759..    2762:    1601351..   1601354:      4:    1597482:
>   33:     2763..    2764:    1597482..   1597483:      2:    1601355:
>   34:     2765..    2837:    1649249..   1649321:     73:    1597484:
>   35:     2838..    2838:    1597038..   1597038:      1:    1649322:
>   36:     2839..    2855:    1601538..   1601554:     17:    1597039:
>   37:     2856..    2856:    1597045..   1597045:      1:    1601555:
>   38:     2857..    2904:    1624547..   1624594:     48:    1597046:
>   39:     2905..    2926:    1600795..   1600816:     22:    1624595:
>   40:     2927..    2942:    1602034..   1602049:     16:    1600817:
>   41:     2943..    2963:    1600817..   1600837:     21:    1602050:
>   42:     2964..    2979:    1602183..   1602198:     16:    1600838:
>   43:     2980..    3001:    1600927..   1600948:     22:    1602199:
>   44:     3002..    3043:    1621164..   1621205:     42:    1600949:
>   45:     3044..    3053:    1599231..   1599240:     10:    1621206:
>   46:     3054..    3066:    1601952..   1601964:     13:    1599241:
>   47:     3067..    3067:    1597056..   1597056:      1:    1601965:
>   48:     3068..    3084:    1602375..   1602391:     17:    1597057:
>   49:     3085..    3094:    1599290..   1599299:     10:    1602392:
>   50:     3095..    3096:    1601355..   1601356:      2:    1599300:
>   51:     3097..    3107:    1600717..   1600727:     11:    1601357:
>   52:     3108..    3156:    1642892..   1642940:     49:    1600728:
>   53:     3157..    3157:    1597059..   1597059:      1:    1642941:
>   54:     3158..    3251:    1649322..   1649415:     94:    1597060:
>   55:     3252..    3254:    1599241..   1599243:      3:    1649416:
>   56:     3255..    3304:    1645466..   1645515:     50:    1599244:
>   57:     3305..    3305:    1597100..   1597100:      1:    1645516:
>   58:     3306..    3312:    1601357..   1601363:      7:    1597101:
>   59:     3313..    3319:    1599300..   1599306:      7:    1601364:
>   60:     3320..    3331:    1601611..   1601622:     12:    1599307:
>   61:     3332..    3339:    1600838..   1600845:      8:    1601623:
>   62:     3340..    3343:    1601419..   1601422:      4:    1600846:
>   63:     3344..    3351:    1600846..   1600853:      8:    1601423:
>   64:     3352..    3432:    1649416..   1649496:     81:    1600854:
>   65:     3433..    3433:    1597109..   1597109:      1:    1649497:
>   66:     3434..    3489:    1649497..   1649552:     56:    1597110:
>   67:     3490..    3491:    1599227..   1599228:      2:    1649553:
>   68:     3492..    3521:    1619348..   1619377:     30:    1599229:
>   69:     3522..    3523:    1599307..   1599308:      2:    1619378:
>   70:     3524..    3530:    1601688..   1601694:      7:    1599309:
>   71:     3531..    3539:    1600949..   1600957:      9:    1601695:
>   72:     3540..    3579:    1629356..   1629395:     40:    1600958:
>   73:     3580..    3580:    1597124..   1597124:      1:    1629396:
>   74:     3581..    3601:    1604219..   1604239:     21:    1597125:
>   75:     3602..    3603:    1599585..   1599586:      2:    1604240:
>   76:     3604..    3614:    1602636..   1602646:     11:    1599587:
>   77:     3615..    3616:    1599587..   1599588:      2:    1602647:
>   78:     3617..    3677:    1649553..   1649613:     61:    1599589:
>   79:     3678..    3680:    1599692..   1599694:      3:    1649614:
>   80:     3681..    3723:    1647818..   1647860:     43:    1599695:
>   81:     3724..    3726:    1599821..   1599823:      3:    1647861:
>   82:     3727..    3756:    1622218..   1622247:     30:    1599824:
>   83:     3757..    3759:    1600630..   1600632:      3:    1622248:
>   84:     3760..    3766:    1603288..   1603294:      7:    1600633:
>   85:     3767..    3768:    1600633..   1600634:      2:    1603295:
>   86:     3769..    3950:   76053306..  76053487:    182:    1600635:
>   87:     3951..    3958:    1600958..   1600965:      8:   76053488:
>   88:     3959..    3986:    1619921..   1619948:     28:    1600966:
>   89:     3987..    3995:    1600966..   1600974:      9:    1619949:
>   90:     3996..    4036:    1649614..   1649654:     41:    1600975:
>   91:     4037..    4045:    1600975..   1600983:      9:    1649655:
>   92:     4046..    4050:    1601423..   1601427:      5:    1600984:
>   93:     4051..    4052:    1600854..   1600855:      2:    1601428:
>   94:     4053..    4055:    1601555..   1601557:      3:    1600856:
>   95:     4056..    4056:    1597129..   1597129:      1:    1601558:
>   96:     4057..    4059:    1601745..   1601747:      3:    1597130:
>   97:     4060..    4060:    1597134..   1597134:      1:    1601748:
>   98:     4061..    4063:    1602050..   1602052:      3:    1597135:
>   99:     4064..    4064:    1597137..   1597137:      1:    1602053:
>  100:     4065..    4079:    1604297..   1604311:     15:    1597138:
>  101:     4080..    4088:    1600987..   1600995:      9:    1604312:
>  102:     4089..    4095:    1603295..   1603301:      7:    1600996:
>  103:     4096..    4106:    1600996..   1601006:     11:    1603302:
>  104:     4107..    4117:    1622600..   1622610:     11:    1601007:
>  105:     4118..    4119:    1601007..   1601008:      2:    1622611:
>  106:     4120..    4129:    1622611..   1622620:     10:    1601009:
>  107:     4130..    4131:    1601009..   1601010:      2:    1622621:
>  108:     4132..    4141:    1622621..   1622630:     10:    1601011:
>  109:     4142..    4145:    1601011..   1601014:      4:    1622631:
>  110:     4146..    4155:    1622986..   1622995:     10:    1601015:
>  111:     4156..    4157:    1601015..   1601016:      2:    1622996:
>  112:     4158..    4168:    1622996..   1623006:     11:    1601017:
>  113:     4169..    4170:    1601017..   1601018:      2:    1623007:
>  114:     4171..    4180:    1623007..   1623016:     10:    1601019:
>  115:     4181..    4182:    1601019..   1601020:      2:    1623017:
>  116:     4183..    4192:    1624473..   1624482:     10:    1601021:
>  117:     4193..    4195:    1601021..   1601023:      3:    1624483:
>  118:     4196..    4205:    1624796..   1624805:     10:    1601024:
>  119:     4206..    4207:    1601024..   1601025:      2:    1624806:
>  120:     4208..    4217:    1624806..   1624815:     10:    1601026:
>  121:     4218..    4220:    1601026..   1601028:      3:    1624816:
>  122:     4221..    4230:    1625972..   1625981:     10:    1601029:
>  123:     4231..    4408:    1648626..   1648803:    178:    1625982:
>  124:     4409..    4411:    1602199..   1602201:      3:    1648804:
>  125:     4412..    4434:    1601328..   1601350:     23:    1602202:
>  126:     4435..    4437:    1602647..   1602649:      3:    1601351:
>  127:     4438..    4439:    1601029..   1601030:      2:    1602650:
>  128:     4440..    4442:    1602755..   1602757:      3:    1601031:
>  129:     4443..    4480:    1601650..   1601687:     38:    1602758:
>  130:     4481..    4491:    1629530..   1629540:     11:    1601688:
>  131:     4492..    4560:    1624404..   1624472:     69:    1629541:
>  132:     4561..    4571:    1629541..   1629551:     11:    1624473:
>  133:     4572..    4582:    1601031..   1601041:     11:    1629552:
>  134:     4583..    4586:    1603302..   1603305:      4:    1601042:
>  135:     4587..    4620:    1602537..   1602570:     34:    1603306:
>  136:     4621..    4631:    1629716..   1629726:     11:    1602571:
>  137:     4632..    4634:    1601042..   1601044:      3:    1629727:
>  138:     4635..    6143:  156004864.. 156006372:   1509:    1601045: last,eof
> data.txt: 139 extents found
> 
> the I tried to defrag it
> 
> $ btrfs fi defra  data.txt
> $ sudo filefrag -v data.txt
> Filesystem type is: 9123683e
> File size of data.txt is 25165824 (6144 blocks of 4096 bytes)
>  ext:     logical_offset:        physical_offset: length:   expected: flags:
>    0:        0..    6143:  164002967.. 164009110:   6144:             last,eof
> data.txt: 1 extent found
> 
> So it seems that the defrag works

Be very careful how you set up this test case.  If you use fallocate on
a file, it has a _permanent_ effect on the inode, and alters a lot of
normal btrfs behavior downstream.  You won't see these effects if you
just write some data to a file without using prealloc.

> [*] https://www.kernel.org/doc/Documentation/filesystems/fiemap.txt
> > 
> > https://pastebin.com/1ufErVMs
> > 
> > If I unwind the interleaving, it looks like all the extents fall into
> > two localities and within each locality the extents aren't that far
> > apart - so my guess is that this file is also not meaningfully
> > fragmented, in practice. Surely the drive firmware will reorder the
> > reads to arrive at the least amount of seeks?
> > 
> 
> 
> -- 
> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
