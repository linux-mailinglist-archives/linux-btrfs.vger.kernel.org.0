Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B230B510AB3
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Apr 2022 22:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355120AbiDZUqh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Apr 2022 16:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241134AbiDZUqg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Apr 2022 16:46:36 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C4A13C29D
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Apr 2022 13:43:27 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:58260 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1njS1u-0003qz-G0 by authid <merlins.org> with srv_auth_plain; Tue, 26 Apr 2022 13:43:26 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1njS1u-004TvI-AG; Tue, 26 Apr 2022 13:43:26 -0700
Date:   Tue, 26 Apr 2022 13:43:26 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220426204326.GK12542@merlins.org>
References: <CAEzrpqcMV+paWShgAnF8d9WaSQ1Fd5R_DZPRQp-+VNsJGDoASg@mail.gmail.com>
 <20220424212058.GD29107@merlins.org>
 <CAEzrpqcBvh0MC6WeXQ+-80igZhg6t68OcgZnKi6xu+r=njifeA@mail.gmail.com>
 <20220424223819.GE29107@merlins.org>
 <CAEzrpqdBWMcai2uMe=kPxYshUe8wV0YX3Ge1pZW8aG_BSO-i-w@mail.gmail.com>
 <20220424231446.GF29107@merlins.org>
 <CAEzrpqcGy3aac6Lb7PKux+nA2KzDgbPSMyjYG6B-0TbgXXP=-A@mail.gmail.com>
 <20220425002415.GG29107@merlins.org>
 <CAEzrpqcQkiMJt1B4Bx9NrCcRys1MD+_5Y3riActXYC6RQrkakw@mail.gmail.com>
 <20220426002804.GI29107@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426002804.GI29107@merlins.org>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 24.5.124.255
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Generally would you say we're still on the right path and helping your
recovery tools getting better, or is it getting close or to the time
where I should restore from backups?

On Mon, Apr 25, 2022 at 05:28:04PM -0700, Marc MERLIN wrote:
> On Sun, Apr 24, 2022 at 08:36:42PM -0400, Josef Bacik wrote:
> > > I ran it a second time and got the same output
> > 
> > Well thats something at least, I've rigged it up to dump the leaf so I
> > can see wtf is going on here.  Thanks,
> 
> Sorry for the delay, took a while to run:
> (gdb) run rescue init-extent-tree /dev/mapper/dshelf1
> Starting program: /var/local/src/btrfs-progs-josefbacik/btrfs rescue init-extent-tree /dev/mapper/dshelf1
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
> 
> FS_INFO IS 0x55555564cbc0
> JOSEF: root 9
> Couldn't find the last root for 8
> inserting block group 253969301504
>         item 33 key (328057487360 BLOCK_GROUP_ITEM 1073741824) itemoff 15467 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
>         item 173 key (477844471808 BLOCK_GROUP_ITEM 1073741824) itemoff 12107 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
>         item 174 key (478918213632 BLOCK_GROUP_ITEM 1073741824) itemoff 12083 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
>         item 175 key (479991955456 BLOCK_GROUP_ITEM 1073741824) itemoff 12059 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
>         item 176 key (481065697280 BLOCK_GROUP_ITEM 1073741824) itemoff 12035 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
>         item 177 key (482139439104 BLOCK_GROUP_ITEM 1073741824) itemoff 12011 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
>         item 178 key (483213180928 BLOCK_GROUP_ITEM 1073741824) itemoff 11987 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
>         item 179 key (484286922752 BLOCK_GROUP_ITEM 1073741824) itemoff 11963 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
>         item 180 key (485360664576 BLOCK_GROUP_ITEM 1073741824) itemoff 11939 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
>         item 181 key (486434406400 BLOCK_GROUP_ITEM 1073741824) itemoff 11915 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
>         item 182 key (487508148224 BLOCK_GROUP_ITEM 1073741824) itemoff 11891 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
>         item 183 key (488581890048 BLOCK_GROUP_ITEM 1073741824) itemoff 11867 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
>         item 184 key (489655631872 BLOCK_GROUP_ITEM 1073741824) itemoff 11843 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
>         item 185 key (490729373696 BLOCK_GROUP_ITEM 1073741824) itemoff 11819 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
>         item 186 key (491803115520 BLOCK_GROUP_ITEM 1073741824) itemoff 11795 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
>         item 187 key (492876857344 BLOCK_GROUP_ITEM 1073741824) itemoff 11771 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
>         item 188 key (493950599168 BLOCK_GROUP_ITEM 1073741824) itemoff 11747 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
>         item 189 key (495024340992 BLOCK_GROUP_ITEM 1073741824) itemoff 11723 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
>         item 190 key (496098082816 BLOCK_GROUP_ITEM 1073741824) itemoff 11699 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
>         item 191 key (497171824640 BLOCK_GROUP_ITEM 1073741824) itemoff 11675 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
>         item 192 key (498245566464 BLOCK_GROUP_ITEM 1073741824) itemoff 11651 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
>         item 193 key (499319308288 BLOCK_GROUP_ITEM 1073741824) itemoff 11627 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
>         item 194 key (500393050112 BLOCK_GROUP_ITEM 1073741824) itemoff 11603 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
>         item 195 key (501466791936 BLOCK_GROUP_ITEM 1073741824) itemoff 11579 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
>         item 196 key (502540533760 BLOCK_GROUP_ITEM 1073741824) itemoff 11555 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
>         item 197 key (503614275584 BLOCK_GROUP_ITEM 1073741824) itemoff 11531 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
>         item 198 key (504688017408 BLOCK_GROUP_ITEM 1073741824) itemoff 11507 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
>         item 199 key (505761759232 BLOCK_GROUP_ITEM 1073741824) itemoff 11483 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
>         item 200 key (506835501056 BLOCK_GROUP_ITEM 1073741824) itemoff 11459 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
>         item 201 key (507909242880 BLOCK_GROUP_ITEM 1073741824) itemoff 11435 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
>         item 202 key (508982984704 BLOCK_GROUP_ITEM 1073741824) itemoff 11411 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
>         item 203 key (510056726528 BLOCK_GROUP_ITEM 1073741824) itemoff 11387 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
>         item 204 key (511130468352 BLOCK_GROUP_ITEM 1073741824) itemoff 11363 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
>         item 205 key (512204210176 BLOCK_GROUP_ITEM 1073741824) itemoff 11339 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
>         item 206 key (513277952000 BLOCK_GROUP_ITEM 1073741824) itemoff 11315 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
>         item 207 key (514351693824 BLOCK_GROUP_ITEM 1073741824) itemoff 11291 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
>         item 208 key (515425435648 BLOCK_GROUP_ITEM 1073741824) itemoff 11267 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
>         item 209 key (516499177472 BLOCK_GROUP_ITEM 1073741824) itemoff 11243 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
>         item 210 key (517572919296 BLOCK_GROUP_ITEM 1073741824) itemoff 11219 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
>         item 211 key (518646661120 BLOCK_GROUP_ITEM 1073741824) itemoff 11195 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
>         item 212 key (519720402944 BLOCK_GROUP_ITEM 1073741824) itemoff 11171 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
>         item 213 key (520794144768 BLOCK_GROUP_ITEM 1073741824) itemoff 11147 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
>         item 214 key (521867886592 BLOCK_GROUP_ITEM 1073741824) itemoff 11123 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
>         item 215 key (522941628416 BLOCK_GROUP_ITEM 1073741824) itemoff 11099 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
>         item 216 key (524015370240 BLOCK_GROUP_ITEM 1073741824) itemoff 11075 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
>         item 217 key (525089112064 BLOCK_GROUP_ITEM 1073741824) itemoff 11051 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
> ERROR: Error adding block group -17
> ERROR: commit_root already set when starting transaction
> WARNING: reserved space leaked, flag=0x4 bytes_reserved=81920
> extent buffer leak: start 67469312 len 16384
> extent buffer leak: start 29540352 len 16384
> WARNING: dirty eb leak (aborted trans): start 29540352 len 16384
> extent buffer leak: start 29589504 len 16384
> WARNING: dirty eb leak (aborted trans): start 29589504 len 16384
> extent buffer leak: start 29655040 len 16384
> WARNING: dirty eb leak (aborted trans): start 29655040 len 16384
> Init extent tree failed
> [Inferior 1 (process 24213) exited with code 0357]
> 
> -- 
> "A mouse is a device used to point at the xterm you want to type in" - A.S.R.
>  
> Home page: http://marc.merlins.org/  
> 

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
