Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9219C520318
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 May 2022 19:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239415AbiEIREy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 May 2022 13:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239412AbiEIREx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 May 2022 13:04:53 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685A8205E7
        for <linux-btrfs@vger.kernel.org>; Mon,  9 May 2022 10:00:56 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:58486 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1no6kg-0003VU-M3 by authid <merlins.org> with srv_auth_plain; Mon, 09 May 2022 10:00:55 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1no6kg-00G1gz-Ac; Mon, 09 May 2022 10:00:54 -0700
Date:   Mon, 9 May 2022 10:00:54 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220509170054.GW12542@merlins.org>
References: <20220507193628.GO12542@merlins.org>
 <20220508194557.GP12542@merlins.org>
 <CAEzrpqej2giQzLDcxsfze=e=uYOyMEh1v25V3R2xP_AEeHUAsw@mail.gmail.com>
 <20220508205224.GQ12542@merlins.org>
 <20220508212050.GR12542@merlins.org>
 <CAEzrpqdMFJ2cm0URWqwFehkQQzmrgYO+CdoibSUqqfN1hkGOvQ@mail.gmail.com>
 <20220508221444.GS12542@merlins.org>
 <CAEzrpqe=qUMdC-8UTeuSy7niO9i8PhFGa6auMmQk_ave30gKUw@mail.gmail.com>
 <20220509004635.GT12542@merlins.org>
 <CAEzrpqfYRkASd+7ac_2dO+bNtacYwE9ndcYDWsp9B4Esq9Hwug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqfYRkASd+7ac_2dO+bNtacYwE9ndcYDWsp9B4Esq9Hwug@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 24.5.124.255
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 09, 2022 at 12:17:30PM -0400, Josef Bacik wrote:
> On Sun, May 8, 2022 at 8:46 PM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Sun, May 08, 2022 at 08:22:19PM -0400, Josef Bacik wrote:
> > > On Sun, May 8, 2022 at 6:14 PM Marc MERLIN <marc@merlins.org> wrote:
> > > >
> > > > On Sun, May 08, 2022 at 05:49:17PM -0400, Josef Bacik wrote:
> > > > > Yeah this is the divide by 0, the error you posted earlier is likely
> > > > > because of the code refactor I did to make the delete thing work.
> > > > > I've added some more debugging to see if we're not deleting this
> > > > > problem bytenr during the search for bad extents.  Thanks,
> > > >
> > >
> > > Ooooh right this is the other problem, overlapping extents.  This is
> > > going to be trickier to work out, I'll start writing it up, but I want
> > > to make it automatic as well, so probably won't have anything until
> > > the morning.  Thanks,
> >
> > Thanks for the heads up
> 
> Ok I've pushed some code, but I'm sitting in a dealership so testing
> was light.  I've added a 10 second pause before doing deletions from
> the new code to give you time to spot check if the numbers look
> insane.  It'll only do that 5 times, so if everything looks good it'll
> just yolo delete stuff as it goes after 5 pauses.  Let me know if you
> have trouble, thanks,

Thanks.
It worked for a while, and then failed in a new way?

inserting block group 15837217947648
inserting block group 15838291689472
inserting block group 15839365431296
inserting block group 15840439173120
inserting block group 15842586656768
searching 4 for bad extents
processed 1032192 of 1064960 possible bytes, 96%
searching 5 for bad extents
processed 16384 of 10977280 possible bytes, 0%
Found an overlapping extent orig [123032674304 123032702976] current [123032702976 123032731648]
I'm going to give you 10 seconds to bail if that doesn't look right, I'll only ask 5 times before I just assume I didn't break anythin
g1
2
0
The newly found extent is older, deleting it
inode ref info failed???
DS1
Deleting [1003, 108, 151552] root 13576823717888 path top 13576823717888 top slot 0 leaf 13576824340480 slot 92

searching 5 for bad extents
processed 16384 of 10977280 possible bytes, 0%
Found an overlapping extent orig [123032731648 123032760320] current [123032760320 123032788992]
I'm going to give you 10 seconds to bail if that doesn't look right, I'll only ask 5 times before I just assume I didn't break anything1
2
3
4
5
6
7
8
9
10
The newly found extent is older, deleting it
inode ref info failed???
DS1
Deleting [1003, 108, 413696] root 13576823898112 path top 13576823898112 top slot 0 leaf 13576824553472 slot 93

searching 5 for bad extents
processed 16384 of 10977280 possible bytes, 0%
Found an overlapping extent orig [128877895680 128877924352] current [128877924352 128877948928]
I'm going to give you 10 seconds to bail if that doesn't look right, I'll only ask 5 times before I just assume I didn't break anything1
2
3
4
5
6
7
8
9
10
The newly found extent is older, deleting it
inode ref info failed???
DS1
Deleting [1003, 108, 675840] root 13576823717888 path top 13576823717888 top slot 0 leaf 13576824340480 slot 94

searching 5 for bad extents
processed 16384 of 10977280 possible bytes, 0%
Found an overlapping extent orig [128877948928 128877977600] current [128877977600 128878002176]
I'm going to give you 10 seconds to bail if that doesn't look right, I'll only ask 5 times before I just assume I didn't break anything1
2
3
4
5
6
7
8
9
10
The newly found extent is older, deleting it
inode ref info failed???
DS1
Deleting [1003, 108, 937984] root 13576823898112 path top 13576823898112 top slot 0 leaf 13576824553472 slot 95

searching 5 for bad extents
processed 16384 of 10977280 possible bytes, 0%
Found an overlapping extent orig [128878002176 128878030848] current [128878030848 128878055424]
I'm going to give you 10 seconds to bail if that doesn't look right, I'll only ask 5 times before I just assume I didn't break anything1
2
3
4
5
6
7
8
9
10
The newly found extent is older, deleting it
inode ref info failed???
DS1
Deleting [1003, 108, 1200128] root 13576823717888 path top 13576823717888 top slot 0 leaf 13576824340480 slot 96

searching 5 for bad extents
processed 16384 of 10977280 possible bytes, 0%
Found an overlapping extent orig [128878055424 128878080000] current [128878080000 128878108672]
The newly found extent is older, deleting it
inode ref info failed???
DS1
Deleting [1003, 108, 1462272] root 13576823898112 path top 13576823898112 top slot 0 leaf 13576824553472 slot 97

searching 5 for bad extents
processed 16384 of 10977280 possible bytes, 0%
Found an overlapping extent orig [147706290176 147706318848] current [147706318848 147706343424]
The newly found extent is older, deleting it
inode ref info failed???
DS1   
Deleting [1003, 108, 1855488] root 13576823717888 path top 13576823717888 top slot 0 leaf 13576824340480 slot 99

searching 5 for bad extents
processed 16384 of 10977280 possible bytes, 0%
Found an overlapping extent orig [147706343424 147706372096] current [147706372096 147706400768]
The newly found extent is older, deleting it
inode ref info failed???
DS1   
Deleting [1003, 108, 2125824] root 13576823898112 path top 13576823898112 top slot 0 leaf 13576824553472 slot 101

searching 5 for bad extents
processed 16384 of 10977280 possible bytes, 0%
Found an overlapping extent orig [147706400768 147706429440] current [147706429440 147706458112]
The newly found extent is older, deleting it
inode ref info failed???
DS1   
Deleting [1003, 108, 2387968] root 13576823717888 path top 13576823717888 top slot 0 leaf 13576824340480 slot 102

searching 5 for bad extents
processed 16384 of 10977280 possible bytes, 0%
Found an overlapping extent orig [128878108672 128878133248] current [128878133248 128878157824]
The newly found extent is older, deleting it
inode ref info failed???
DS1   
Deleting [1003, 108, 2650112] root 13576823898112 path top 13576823898112 top slot 0 leaf 13576824553472 slot 103

searching 5 for bad extents
processed 16384 of 10977280 possible bytes, 0%
Found an overlapping extent orig [147706458112 147706482688] current [147706482688 147706507264]
The newly found extent is older, deleting it
inode ref info failed???
DS1   
Deleting [1003, 108, 2752512] root 13576823717888 path top 13576823717888 top slot 0 leaf 13576824340480 slot 103

searching 5 for bad extents
processed 16384 of 10977280 possible bytes, 0%
Found an overlapping extent orig [193839411200 193839439872] current [193839439872 193839468544]
The newly found extent is older, deleting it
inode ref info failed???
DS1   
Deleting [1003, 108, 3145728] root 13576823898112 path top 13576823898112 top slot 0 leaf 13576824553472 slot 105

searching 5 for bad extents
processed 16384 of 10977280 possible bytes, 0%
Found an overlapping extent orig [193839468544 193839497216] current [193839497216 193839529984]
The newly found extent is older, deleting it
inode ref info failed???
DS1   
Deleting [1003, 108, 3407872] root 13576823717888 path top 13576823717888 top slot 0 leaf 13576824340480 slot 106

searching 5 for bad extents
processed 16384 of 10977280 possible bytes, 0%
Found an overlapping extent orig [193839529984 193839570944] current [193839570944 193839611904]
The newly found extent is older, deleting it
inode ref info failed???
DS1   
Deleting [1003, 108, 3670016] root 13576823898112 path top 13576823898112 top slot 0 leaf 13576824553472 slot 107

searching 5 for bad extents
processed 16384 of 10977280 possible bytes, 0%
Found an overlapping extent orig [193839611904 193839656960] current [193839656960 193839665152]
The newly found extent is older, deleting it
inode ref info failed???
DS1   
Deleting [1003, 108, 3932160] root 13576823717888 path top 13576823717888 top slot 0 leaf 13576824340480 slot 108

(...)

searching 5 for bad extents
processed 32768 of 10977280 possible bytes, 0%
Found an overlapping extent orig [109405609984 109405650944] current [109405650944 109405659136]
The newly found extent is older, deleting it
inode ref info failed???
DS1
Deleting [1003, 108, 16121856] root 13576823717888 path top 13576823717888 top slot 0 leaf 11970640084992 slot 25

searching 5 for bad extents
processed 32768 of 10977280 possible bytes, 0%
Found an overlapping extent orig [153036664832 153036668928] current [153036668928 153036689408]
The original extent is older, deleting it
inode ref info failed???
DS1
Deleting [1003, 108, 15069184] root 13576823898112 path top 13576823898112 top slot 0 leaf 11970640101376 slot 20

searching 5 for bad extents
processed 32768 of 10977280 possible bytes, 0%
Found an overlapping extent orig [153036664832 153036668928] current [153036668928 153036689408]
The original extent is older, deleting it
inode ref info failed???
DS1
ERROR: error searching for key?? -2

wtf
it failed?? -2
ERROR: failed to clear bad extents
doing close???
ERROR: attempt to start transaction over already running one
WARNING: reserved space leaked, flag=0x4 bytes_reserved=49152
extent buffer leak: start 13576823717888 len 16384
extent buffer leak: start 13576823717888 len 16384
WARNING: dirty eb leak (aborted trans): start 13576823717888 len 16384
extent buffer leak: start 13576823750656 len 16384
extent buffer leak: start 13576823750656 len 16384
WARNING: dirty eb leak (aborted trans): start 13576823750656 len 16384
extent buffer leak: start 11970640084992 len 16384
extent buffer leak: start 11970640084992 len 16384
WARNING: dirty eb leak (aborted trans): start 11970640084992 len 16384
Init extent tree failed
[Inferior 1 (process 19271) exited with code 0376]

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
