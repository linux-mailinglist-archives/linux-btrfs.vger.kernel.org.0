Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A98683417
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Jan 2023 18:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjAaRl6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Jan 2023 12:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjAaRl5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Jan 2023 12:41:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4C3577D6;
        Tue, 31 Jan 2023 09:41:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CF8B6154C;
        Tue, 31 Jan 2023 17:41:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0945C4339C;
        Tue, 31 Jan 2023 17:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675186913;
        bh=4KKHRIjeCKN1OEbX1CsFRePNKu9RfTsnq1P1nYShyiU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NONtYKg7hm5nXgSCqz01LELTpWpqAiNGnvtDfVAxbmEO1YeJOACMOi2Xksa/AqzYJ
         3ZLJnutHQzarUJtzZb2W5fevqHe3HynXTF1DShf3leeMUAVQBapnE0ZGQJkVJHSTgy
         EUjolo1Cp3BM0CXHJEIvr7vOYbjdN+IkgRccr7Fdo5fSFN3LqqcY5dkBeBPy1027j9
         jAfYvcXwiwPS053A+q+Jf0s0aC7wharVIsTgXA4xEZlZzXkwowmmwN9pNrP/qMrm0H
         kkonPuhZy35Mnj1sEXswqIepbRgwP6Xyizv3HbHL0cTpTNnSfnzoGfM0HiktsXvges
         LQaO2MvVGSEKw==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-16346330067so20347554fac.3;
        Tue, 31 Jan 2023 09:41:53 -0800 (PST)
X-Gm-Message-State: AO0yUKUgE8PBNVb0PJNY6WZnk4C5VN6nkzjeoCBlS7l7cLWb5XINfko0
        K6SrSLn4RIFW0hwhY4dLQ5DnW7fiIuxwcIjbHTA=
X-Google-Smtp-Source: AK7set/QugHowlX1vfwf9nVe/5jH/qhrgPefElB+EFYFkF/3B5L5sHKOjL3tsaU8TUMUtpKlkyOyHCKtBZBMKRxMtUQ=
X-Received: by 2002:a05:6871:204:b0:15b:945f:9102 with SMTP id
 t4-20020a056871020400b0015b945f9102mr26244oad.92.1675186912565; Tue, 31 Jan
 2023 09:41:52 -0800 (PST)
MIME-Version: 1.0
References: <ae169fc6-f504-28f0-a098-6fa6a4dfb612@leemhuis.info>
 <20230102154050.GJ11562@twin.jikos.cz> <ac2f141b-b03a-6054-8250-d27a5b568027@gmx.com>
 <03ad09d2-0c0e-ed82-509a-9758fbc81f64@prnet.org> <CAL3q7H75DScFAnUGHFn9x=ZmnCbd_u3+KsLU6qKOGPeVogOQwg@mail.gmail.com>
 <544a0942-d505-148e-9b65-f5b366a3a0e3@prnet.org> <CAL3q7H7b+hrro9weiE2fLFMwvUm0PBjKPqetpQyGHUFqQd8s=w@mail.gmail.com>
 <ec38dc9b-6e54-7166-402a-fe92c38170d0@prnet.org> <CAL3q7H7anKa6ova5MYx4ZDsz6gwaq-K0OSRZuNEo-hNft7pZHQ@mail.gmail.com>
 <3b5c7161-1a48-619b-b6b3-1868b7695c97@prnet.org> <CAL3q7H7pEYNpzZYgNRxXwMz6ftCK53u46CQjPAh8nTO4ixgYwg@mail.gmail.com>
 <CAL3q7H5bdpH621LRO+mr98r_MBhNFLU3q1NQ8erOjZFkFAzf-A@mail.gmail.com>
 <d4f0758b-d11c-aee8-43df-885233a14a80@prnet.org> <ed7d2424-fb13-eccf-11ea-ac08c618f5aa@prnet.org>
 <CAL3q7H4zfz-9Mb=kScsQ_a1G9NX4ayPZStnSvNNYsbhpoY0wmg@mail.gmail.com>
 <51fa20b5-5ac2-ccca-847f-b5a87e604544@prnet.org> <CAL3q7H46_+Z0FpD9+Bunn_Ta66XFgJkqz3SHRxdr4_ySsg=COw@mail.gmail.com>
 <20d7b129-9cdc-19b1-bbd0-d9dd9a92d7d4@prnet.org>
In-Reply-To: <20d7b129-9cdc-19b1-bbd0-d9dd9a92d7d4@prnet.org>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 31 Jan 2023 17:41:16 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5FKCt=Sd2CP6Dr8j+Gv1HkkAKq2zowBO3YWrvwXL4Dmg@mail.gmail.com>
Message-ID: <CAL3q7H5FKCt=Sd2CP6Dr8j+Gv1HkkAKq2zowBO3YWrvwXL4Dmg@mail.gmail.com>
Subject: Re: [regression] Bug 216851 - btrfs write time corrupting for log tree
To:     David Arendt <admin@prnet.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, dsterba@suse.cz,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 30, 2023 at 9:07 PM David Arendt <admin@prnet.org> wrote:
>
> On 1/23/23 23:14, Filipe Manana wrote:
> > On Mon, Jan 23, 2023 at 9:06 PM David Arendt <admin@prnet.org> wrote:
> >> On 1/23/23 11:28, Filipe Manana wrote:
> >>> On Sun, Jan 22, 2023 at 3:53 PM David Arendt <admin@prnet.org> wrote:
> >>>> On 1/10/23 22:12, David Arendt wrote:
> >>>> Hi,
> >>>>
> >>>> In 6.2-rc3 + your patches, the problem did not appear within 2 weeks. I
> >>>> skipped rc4 and today I upgraded to 6.2-rc5 which should have to patches
> >>>> included (or not ?). About one hour later, the filesystem turned again
> >>>> read-only with the following kernel log entries:
> >>> Ok, so 6.2-rc5 has the first 5 patches of the patchset.
> >>> If the whole patchset fixed the problem for 2 weeks, then I think
> >>> there's only one thing left to test, which is to add patch 6 on top of
> >>> 6.2-rc5:
> >>>
> >>> https://lore.kernel.org/linux-btrfs/ff77f41924e197d99e62ef323f03467c87ef43a0.1673361215.git.fdmanana@suse.com/
> >>>
> >>> Are you able to try that?
> >>>
> >>> Thanks.
> >> Hi,
> >>
> >> I have applied this patch to 6.2-rc5 and within an hour of intensive
> >> testing, I was not able to reproduce the bug, so I think this patch
> >> probably resolves the bug.
> >>
> >> I will continue running this configuration and will report back when any
> >> problem arises.
> > Nice, thank you.
> > Please report back after a longer while, so the patch can be added to
> > stable, at least 6.1, since there's another report of the same issue
> > but only on 6.1 (like you).
>
> Hi,
>
> The system was now running stable for a week. From now on, I'm testing
> 6.2-rc6 + patch.

Nothing changed in the relevant code with rc6, so it's the same as
testing rc5 + patch.

Ok, so it seems clear enough that patch fixes the problem and should
be backported to 6.1, besides your report, there are 2 more I'm aware
of, all on 6.1.

I'll see it's backported to 6.1 stable.

Thanks for all the testing.

>
> Thanks in advance,
>
> David Arendt
>
> >> Thanks,
> >>
> >> David Arendt
> >>
> >>>> [ 7611.406077] BTRFS critical (device sda2): corrupt leaf:
> >>>> root=18446744073709551610 block=75971280896 slot=71, bad key order, prev
> >>>> (484119 96 1358553) current (484119 96 1358532)
> >>>> [ 7611.406087] BTRFS info (device sda2): leaf 75971280896 gen 5130699
> >>>> total ptrs 105 free space 10909 owner 18446744073709551610
> >>>> [ 7611.406090]     item 0 key (484119 1 0) itemoff 16123 itemsize 160
> >>>> [ 7611.406091]         inode generation 45 size 2198 mode 40700
> >>>> [ 7611.406093]     item 1 key (484119 12 484118) itemoff 16097 itemsize 26
> >>>> [ 7611.406094]     item 2 key (484119 72 15) itemoff 16089 itemsize 8
> >>>> [ 7611.406095]     item 3 key (484119 72 20) itemoff 16081 itemsize 8
> >>>> [ 7611.406097]     item 4 key (484119 72 25) itemoff 16073 itemsize 8
> >>>> [ 7611.406098]     item 5 key (484119 72 30) itemoff 16065 itemsize 8
> >>>> [ 7611.406099]     item 6 key (484119 72 32630) itemoff 16057 itemsize 8
> >>>> [ 7611.406100]     item 7 key (484119 72 40332) itemoff 16049 itemsize 8
> >>>> [ 7611.406101]     item 8 key (484119 72 40335) itemoff 16041 itemsize 8
> >>>> [ 7611.406102]     item 9 key (484119 72 93630) itemoff 16033 itemsize 8
> >>>> [ 7611.406104]     item 10 key (484119 72 101741) itemoff 16025 itemsize 8
> >>>> [ 7611.406105]     item 11 key (484119 72 131485) itemoff 16017 itemsize 8
> >>>> [ 7611.406106]     item 12 key (484119 72 183799) itemoff 16009 itemsize 8
> >>>> [ 7611.406108]     item 13 key (484119 72 183801) itemoff 16001 itemsize 8
> >>>> [ 7611.406109]     item 14 key (484119 72 203038) itemoff 15993 itemsize 8
> >>>> [ 7611.406110]     item 15 key (484119 72 254997) itemoff 15985 itemsize 8
> >>>> [ 7611.406111]     item 16 key (484119 72 255172) itemoff 15977 itemsize 8
> >>>> [ 7611.406112]     item 17 key (484119 72 255208) itemoff 15969 itemsize 8
> >>>> [ 7611.406113]     item 18 key (484119 72 256848) itemoff 15961 itemsize 8
> >>>> [ 7611.406115]     item 19 key (484119 72 264839) itemoff 15953 itemsize 8
> >>>> [ 7611.406116]     item 20 key (484119 72 266090) itemoff 15945 itemsize 8
> >>>> [ 7611.406117]     item 21 key (484119 72 266976) itemoff 15937 itemsize 8
> >>>> [ 7611.406118]     item 22 key (484119 72 267056) itemoff 15929 itemsize 8
> >>>> [ 7611.406120]     item 23 key (484119 72 302340) itemoff 15921 itemsize 8
> >>>> [ 7611.406121]     item 24 key (484119 72 513980) itemoff 15913 itemsize 8
> >>>> [ 7611.406122]     item 25 key (484119 72 848319) itemoff 15905 itemsize 8
> >>>> [ 7611.406123]     item 26 key (484119 72 848845) itemoff 15897 itemsize 8
> >>>> [ 7611.406124]     item 27 key (484119 72 938962) itemoff 15889 itemsize 8
> >>>> [ 7611.406125]     item 28 key (484119 72 1001565) itemoff 15881 itemsize 8
> >>>> [ 7611.406127]     item 29 key (484119 72 1268172) itemoff 15873 itemsize 8
> >>>> [ 7611.406128]     item 30 key (484119 72 1298657) itemoff 15865 itemsize 8
> >>>> [ 7611.406129]     item 31 key (484119 72 1299762) itemoff 15857 itemsize 8
> >>>> [ 7611.406130]     item 32 key (484119 72 1336351) itemoff 15849 itemsize 8
> >>>> [ 7611.406131]     item 33 key (484119 72 1356235) itemoff 15841 itemsize 8
> >>>> [ 7611.406133]     item 34 key (484119 72 1356237) itemoff 15833 itemsize 8
> >>>> [ 7611.406134]     item 35 key (484119 72 1357416) itemoff 15825 itemsize 8
> >>>> [ 7611.406135]     item 36 key (484119 72 1357797) itemoff 15817 itemsize 8
> >>>> [ 7611.406137]     item 37 key (484119 72 1358273) itemoff 15809 itemsize 8
> >>>> [ 7611.406138]     item 38 key (484119 72 1358275) itemoff 15801 itemsize 8
> >>>> [ 7611.406139]     item 39 key (484119 72 1358278) itemoff 15793 itemsize 8
> >>>> [ 7611.406141]     item 40 key (484119 72 1358448) itemoff 15785 itemsize 8
> >>>> [ 7611.406142]     item 41 key (484119 72 1358449) itemoff 15777 itemsize 8
> >>>> [ 7611.406143]     item 42 key (484119 72 1358452) itemoff 15769 itemsize 8
> >>>> [ 7611.406144]     item 43 key (484119 72 1358453) itemoff 15761 itemsize 8
> >>>> [ 7611.406145]     item 44 key (484119 72 1358456) itemoff 15753 itemsize 8
> >>>> [ 7611.406147]     item 45 key (484119 72 1358457) itemoff 15745 itemsize 8
> >>>> [ 7611.406148]     item 46 key (484119 72 1358460) itemoff 15737 itemsize 8
> >>>> [ 7611.406149]     item 47 key (484119 72 1358461) itemoff 15729 itemsize 8
> >>>> [ 7611.406150]     item 48 key (484119 72 1358463) itemoff 15721 itemsize 8
> >>>> [ 7611.406151]     item 49 key (484119 72 1358469) itemoff 15713 itemsize 8
> >>>> [ 7611.406153]     item 50 key (484119 72 1358485) itemoff 15705 itemsize 8
> >>>> [ 7611.406154]     item 51 key (484119 72 1358486) itemoff 15697 itemsize 8
> >>>> [ 7611.406155]     item 52 key (484119 72 1358499) itemoff 15689 itemsize 8
> >>>> [ 7611.406156]     item 53 key (484119 72 1358502) itemoff 15681 itemsize 8
> >>>> [ 7611.406157]     item 54 key (484119 72 1358513) itemoff 15673 itemsize 8
> >>>> [ 7611.406159]     item 55 key (484119 72 1358514) itemoff 15665 itemsize 8
> >>>> [ 7611.406160]     item 56 key (484119 72 1358515) itemoff 15657 itemsize 8
> >>>> [ 7611.406161]     item 57 key (484119 72 1358516) itemoff 15649 itemsize 8
> >>>> [ 7611.406162]     item 58 key (484119 72 1358543) itemoff 15641 itemsize 8
> >>>> [ 7611.406164]     item 59 key (484119 72 1358546) itemoff 15633 itemsize 8
> >>>> [ 7611.406165]     item 60 key (484119 72 1358548) itemoff 15625 itemsize 8
> >>>> [ 7611.406166]     item 61 key (484119 72 1358552) itemoff 15617 itemsize 8
> >>>> [ 7611.406167]     item 62 key (484119 96 1358532) itemoff 15566 itemsize 51
> >>>> [ 7611.406168]     item 63 key (484119 96 1358534) itemoff 15508 itemsize 58
> >>>> [ 7611.406170]     item 64 key (484119 96 1358536) itemoff 15465 itemsize 43
> >>>> [ 7611.406171]     item 65 key (484119 96 1358541) itemoff 15431 itemsize 34
> >>>> [ 7611.406172]     item 66 key (484119 96 1358545) itemoff 15383 itemsize 48
> >>>> [ 7611.406173]     item 67 key (484119 96 1358549) itemoff 15330 itemsize 53
> >>>> [ 7611.406174]     item 68 key (484119 96 1358550) itemoff 15283 itemsize 47
> >>>> [ 7611.406175]     item 69 key (484119 96 1358551) itemoff 15234 itemsize 49
> >>>> [ 7611.406177]     item 70 key (484119 96 1358553) itemoff 15196 itemsize 38
> >>>> [ 7611.406178]     item 71 key (484119 96 1358532) itemoff 15145 itemsize 51
> >>>> [ 7611.406179]     item 72 key (484119 96 1358534) itemoff 15087 itemsize 58
> >>>> [ 7611.406180]     item 73 key (484119 96 1358536) itemoff 15044 itemsize 43
> >>>> [ 7611.406181]     item 74 key (484119 96 1358541) itemoff 15010 itemsize 34
> >>>> [ 7611.406182]     item 75 key (484119 96 1358545) itemoff 14962 itemsize 48
> >>>> [ 7611.406184]     item 76 key (484119 96 1358549) itemoff 14909 itemsize 53
> >>>> [ 7611.406185]     item 77 key (484119 96 1358550) itemoff 14862 itemsize 47
> >>>> [ 7611.406186]     item 78 key (484119 96 1358551) itemoff 14813 itemsize 49
> >>>> [ 7611.406187]     item 79 key (484119 96 1358553) itemoff 14775 itemsize 38
> >>>> [ 7611.406188]     item 80 key (484128 1 0) itemoff 14615 itemsize 160
> >>>> [ 7611.406189]         inode generation 45 size 98304 mode 100644
> >>>> [ 7611.406190]     item 81 key (484128 108 0) itemoff 14562 itemsize 53
> >>>> [ 7611.406192]         extent data disk bytenr 10745529716736 nr 65536
> >>>> [ 7611.406193]         extent data offset 0 nr 65536 ram 65536
> >>>> [ 7611.406194]     item 82 key (484129 1 0) itemoff 14402 itemsize 160
> >>>> [ 7611.406195]         inode generation 45 size 26214400 mode 100644
> >>>> [ 7611.406196]     item 83 key (484129 108 98304) itemoff 14349 itemsize 53
> >>>> [ 7611.406197]         extent data disk bytenr 10744232108032 nr 65536
> >>>> [ 7611.406198]         extent data offset 0 nr 65536 ram 65536
> >>>> [ 7611.406198]     item 84 key (484129 108 589824) itemoff 14296 itemsize 53
> >>>> [ 7611.406200]         extent data disk bytenr 10745529593856 nr 32768
> >>>> [ 7611.406200]         extent data offset 0 nr 32768 ram 32768
> >>>> [ 7611.406201]     item 85 key (484129 108 4685824) itemoff 14243
> >>>> itemsize 53
> >>>> [ 7611.406203]         extent data disk bytenr 10744231481344 nr 32768
> >>>> [ 7611.406203]         extent data offset 0 nr 32768 ram 32768
> >>>> [ 7611.406204]     item 86 key (484129 108 11468800) itemoff 14190
> >>>> itemsize 53
> >>>> [ 7611.406205]         extent data disk bytenr 10745067331584 nr 32768
> >>>> [ 7611.406206]         extent data offset 0 nr 32768 ram 32768
> >>>> [ 7611.406207]     item 87 key (484129 108 13139968) itemoff 14137
> >>>> itemsize 53
> >>>> [ 7611.406208]         extent data disk bytenr 10745022545920 nr 32768
> >>>> [ 7611.406209]         extent data offset 0 nr 32768 ram 32768
> >>>> [ 7611.406210]     item 88 key (484129 108 13795328) itemoff 14084
> >>>> itemsize 53
> >>>> [ 7611.406211]         extent data disk bytenr 10744891514880 nr 32768
> >>>> [ 7611.406212]         extent data offset 0 nr 32768 ram 32768
> >>>> [ 7611.406213]     item 89 key (484129 108 20185088) itemoff 14031
> >>>> itemsize 53
> >>>> [ 7611.406214]         extent data disk bytenr 10745022578688 nr 32768
> >>>> [ 7611.406215]         extent data offset 0 nr 32768 ram 32768
> >>>> [ 7611.406216]     item 90 key (484129 108 22347776) itemoff 13978
> >>>> itemsize 53
> >>>> [ 7611.406217]         extent data disk bytenr 10744205844480 nr 32768
> >>>> [ 7611.406218]         extent data offset 0 nr 32768 ram 32768
> >>>> [ 7611.406218]     item 91 key (484129 108 23429120) itemoff 13925
> >>>> itemsize 53
> >>>> [ 7611.406220]         extent data disk bytenr 10745067364352 nr 32768
> >>>> [ 7611.406220]         extent data offset 0 nr 32768 ram 32768
> >>>> [ 7611.406221]     item 92 key (484129 108 24870912) itemoff 13872
> >>>> itemsize 53
> >>>> [ 7611.406222]         extent data disk bytenr 10745022611456 nr 32768
> >>>> [ 7611.406223]         extent data offset 0 nr 32768 ram 32768
> >>>> [ 7611.406224]     item 93 key (484129 108 25001984) itemoff 13819
> >>>> itemsize 53
> >>>> [ 7611.406225]         extent data disk bytenr 10745022709760 nr 32768
> >>>> [ 7611.406226]         extent data offset 0 nr 32768 ram 32768
> >>>> [ 7611.406227]     item 94 key (484129 108 25165824) itemoff 13766
> >>>> itemsize 53
> >>>> [ 7611.406228]         extent data disk bytenr 10745022742528 nr 32768
> >>>> [ 7611.406229]         extent data offset 0 nr 32768 ram 32768
> >>>> [ 7611.406230]     item 95 key (484147 1 0) itemoff 13606 itemsize 160
> >>>> [ 7611.406231]         inode generation 45 size 886 mode 40755
> >>>> [ 7611.406232]     item 96 key (484147 72 4) itemoff 13598 itemsize 8
> >>>> [ 7611.406233]     item 97 key (484147 72 27) itemoff 13590 itemsize 8
> >>>> [ 7611.406234]     item 98 key (484147 72 35) itemoff 13582 itemsize 8
> >>>> [ 7611.406235]     item 99 key (484147 72 40) itemoff 13574 itemsize 8
> >>>> [ 7611.406236]     item 100 key (484147 72 45) itemoff 13566 itemsize 8
> >>>> [ 7611.406238]     item 101 key (484147 72 52) itemoff 13558 itemsize 8
> >>>> [ 7611.406239]     item 102 key (484147 72 61) itemoff 13550 itemsize 8
> >>>> [ 7611.406240]     item 103 key (484147 72 65) itemoff 13542 itemsize 8
> >>>> [ 7611.406241]     item 104 key (484147 72 88) itemoff 13534 itemsize 8
> >>>> [ 7611.406242] BTRFS error (device sda2): block=75971280896 write time
> >>>> tree block corruption detected
> >>>> [ 7611.406255] ------------[ cut here ]------------
> >>>> [ 7611.406256] WARNING: CPU: 5 PID: 32347 at fs/btrfs/disk-io.c:376
> >>>> csum_one_extent_buffer+0x136/0x140
> >>>> [ 7611.406261] Modules linked in: zfs(PO) zunicode(PO) zzstd(O) zlua(O)
> >>>> zavl(PO) icp(PO) zcommon(PO) znvpair(PO) spl(O)
> >>>> [ 7611.406270] CPU: 5 PID: 32347 Comm: mozStorage #2 Tainted: P
> >>>> W  O       6.2.0-rc5 #1
> >>>> [ 7611.406272] Hardware name: ASUS All Series/H87M-PRO, BIOS 2102 10/28/2014
> >>>> [ 7611.406273] RIP: 0010:csum_one_extent_buffer+0x136/0x140
> >>>> [ 7611.406275] Code: 48 c1 e2 29 48 03 53 70 48 c1 fa 06 81 e1 ff 0f 00
> >>>> 00 48 c1 e2 0c 48 01 ca b9 11 ff ff 01 48 c1 e1 27 48 83 7c 0a 58 fa 75
> >>>> 98 <0f> 0b eb 94 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90
> >>>> [ 7611.406277] RSP: 0018:ffffc9000d803850 EFLAGS: 00010246
> >>>> [ 7611.406279] RAX: 00000000ffffff8b RBX: ffff888411886200 RCX:
> >>>> ffff888000000000
> >>>> [ 7611.406280] RDX: 0000000479022000 RSI: 0000000000000001 RDI:
> >>>> ffff8887fdd5b280
> >>>> [ 7611.406282] RBP: ffff888102fa3000 R08: 00000000ffffdfff R09:
> >>>> 00000000ffffdfff
> >>>> [ 7611.406283] R10: ffffffff82854220 R11: ffffffff82854220 R12:
> >>>> ffff888102fa3000
> >>>> [ 7611.406284] R13: 0000000000001000 R14: ffffea0011e40880 R15:
> >>>> ffff888102fa3000
> >>>> [ 7611.406285] FS:  00007f43d72986c0(0000) GS:ffff8887fdd40000(0000)
> >>>> knlGS:0000000000000000
> >>>> [ 7611.406287] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>>> [ 7611.406288] CR2: 00007f246eb9e000 CR3: 000000040de5e005 CR4:
> >>>> 00000000001706e0
> >>>> [ 7611.406289] Call Trace:
> >>>> [ 7611.406291]  <TASK>
> >>>> [ 7611.406293]  btree_csum_one_bio+0x220/0x2a0
> >>>> [ 7611.406295]  btrfs_submit_metadata_bio+0x84/0xc0
> >>>> [ 7611.406297]  submit_one_bio+0xbd/0x110
> >>>> [ 7611.406300]  btree_write_cache_pages+0x721/0x790
> >>>> [ 7611.406303]  ? __pfx_end_bio_extent_buffer_writepage+0x10/0x10
> >>>> [ 7611.406306]  ? btrfs_search_slot+0x8a5/0xc70
> >>>> [ 7611.406309]  do_writepages+0x99/0x180
> >>>> [ 7611.406313]  ? btrfs_read_extent_buffer+0x8a/0x130
> >>>> [ 7611.406314]  ? merge_state.part.0+0x41/0xf0
> >>>> [ 7611.406317]  filemap_fdatawrite_wbc+0x5a/0x80
> >>>> [ 7611.406321]  __filemap_fdatawrite_range+0x45/0x50
> >>>> [ 7611.406323]  btrfs_write_marked_extents+0x52/0x120
> >>>> [ 7611.406326]  btrfs_sync_log+0x1ce/0x9a0
> >>>> [ 7611.406329]  ? btrfs_unlock_up_safe+0x69/0xc0
> >>>> [ 7611.406332]  ? btrfs_search_forward+0x260/0x340
> >>>> [ 7611.406334]  ? log_new_dir_dentries.isra.0+0x36c/0x390
> >>>> [ 7611.406335]  ? __pfx_autoremove_wake_function+0x10/0x10
> >>>> [ 7611.406339]  ? log_new_dir_dentries.isra.0+0x36c/0x390
> >>>> [ 7611.406340]  ? btrfs_log_inode_parent+0x3e0/0xdf0
> >>>> [ 7611.406342]  ? pagevec_lookup_range_tag+0x1f/0x30
> >>>> [ 7611.406345]  ? __filemap_fdatawait_range+0x46/0xe0
> >>>> [ 7611.406347]  ? perf_event_exec+0xe0/0x310
> >>>> [ 7611.406350]  ? wait_current_trans+0x15/0xe0
> >>>> [ 7611.406353]  ? kmem_cache_alloc+0x226/0x380
> >>>> [ 7611.406357]  ? join_transaction+0x1b/0x3f0
> >>>> [ 7611.406359]  ? dput+0xaf/0x2d0
> >>>> [ 7611.406361]  btrfs_sync_file+0x31f/0x4e0
> >>>> [ 7611.406364]  __x64_sys_fsync+0x32/0x60
> >>>> [ 7611.406367]  do_syscall_64+0x42/0x90
> >>>> [ 7611.406371]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> >>>> [ 7611.406375] RIP: 0033:0x7f440320651a
> >>>> [ 7611.406377] Code: 48 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48
> >>>> 83 ec 18 89 7c 24 0c e8 13 71 f8 ff 8b 7c 24 0c 89 c2 b8 4a 00 00 00 0f
> >>>> 05 <48> 3d 00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 73 71 f8 ff 8b 44 24
> >>>> [ 7611.406378] RSP: 002b:00007f43d7297170 EFLAGS: 00000293 ORIG_RAX:
> >>>> 000000000000004a
> >>>> [ 7611.406381] RAX: ffffffffffffffda RBX: 00007f43ee222be8 RCX:
> >>>> 00007f440320651a
> >>>> [ 7611.406382] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> >>>> 0000000000000090
> >>>> [ 7611.406383] RBP: 0000000000000000 R08: 0000000000000000 R09:
> >>>> 00007f440255e000
> >>>> [ 7611.406384] R10: 0000000000000000 R11: 0000000000000293 R12:
> >>>> 00007f43d63ed038
> >>>> [ 7611.406385] R13: 0000000000000000 R14: 0000000000000002 R15:
> >>>> 0000000000000000
> >>>> [ 7611.406387]  </TASK>
> >>>> [ 7611.406387] ---[ end trace 0000000000000000 ]---
> >>>> [ 7611.459735] BTRFS error (device sda2: state AL): Transaction aborted
> >>>> (error -5)
> >>>> [ 7611.459742] BTRFS: error (device sda2: state AL) in
> >>>> free_log_tree:3248: errno=-5 IO failure
> >>>> [ 7611.459744] BTRFS info (device sda2: state EAL): forced readonly
> >>>> [ 7611.463492] BTRFS warning (device sda2: state EAL): Skipping commit
> >>>> of aborted transaction.
> >>>> [ 7611.463498] BTRFS: error (device sda2: state EAL) in
> >>>> cleanup_transaction:1984: errno=-5 IO failure
> >>>>
> >>>> Thanks in advance,
> >>>>
> >>>> David Arendt
> >>>>
>
