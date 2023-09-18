Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102967A55E1
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Sep 2023 00:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjIRWpx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Sep 2023 18:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjIRWpu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Sep 2023 18:45:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18931CD1
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Sep 2023 15:45:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E5049222F7;
        Mon, 18 Sep 2023 22:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695077131;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ka9isgin/7g9AKBZowJM5DB6dBUwyNPJ2RsnW7PPJY=;
        b=DX/e2U4ZmTU0NHpOiozHTHxzfCVuDEBVZFM3i6aPOubsAmthuG2vcyenE8/pZujJHIuM7N
        Oy8tp7dXUfN7OYaA9CxAc1gT/E/MQIm28Go/31NIM6ZSpIQJc84w6CeRbrT666QVN9Rjz7
        6pHpb9o966Uxr+6uj1ddEkePXqutp2w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695077131;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ka9isgin/7g9AKBZowJM5DB6dBUwyNPJ2RsnW7PPJY=;
        b=qilMbJ5VsVO/PTBy7ZvmgefX5+6FYjc1GOdcGoSr+XgrML/+X+/sxYLnawIjRhn2CnVC1c
        Yr0/rWZmfxyMwPCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B6F3D13480;
        Mon, 18 Sep 2023 22:45:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bnOdKwvTCGWZGQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 18 Sep 2023 22:45:31 +0000
Date:   Tue, 19 Sep 2023 00:38:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.cz
Subject: Re: [PATCH RFC] btrfs-progs: btrfstune -m|M remove 2-stage commit
Message-ID: <20230918223856.GR2747@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <12b53ab9683c805873d26a4881308137e0bd324e.1692097274.git.anand.jain@oracle.com>
 <20230817115229.GJ2420@twin.jikos.cz>
 <161c8ab2-2f8c-ce87-783d-f7f0993074af@oracle.com>
 <ef88fc2a-b845-4637-b006-43ecc511d9fd@suse.com>
 <df569834-1949-5c1e-dd99-8da105a10b38@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df569834-1949-5c1e-dd99-8da105a10b38@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Aug 19, 2023 at 07:14:40PM +0800, Anand Jain wrote:
> 
> 
> On 18/08/2023 17:27, Qu Wenruo wrote:
> > 
> > 
> > On 2023/8/18 17:21, Anand Jain wrote:
> >> On 17/08/2023 19:52, David Sterba wrote:
> >>> On Tue, Aug 15, 2023 at 08:53:24PM +0800, Anand Jain wrote:
> >>>> The btrfstune -m|M operation changes the fsid and preserves the 
> >>>> original
> >>>> fsid in the metadata_uuid.
> >>>>
> >>>> Changing the fsid happens in two commits in the function
> >>>> set_metadata_uuid()
> >>>> - Stage 1 commits the superblock with the CHANGING_FSID_V2 flag.
> >>>> - Stage 2 updates the fsid in fs_info->super_copy (local memory),
> >>>>    resets the CHANGING_FSID_V2 flag (local memory),
> >>>>    and then calls commit.
> >>>>
> >>>> The two-stage operation with the CHANGING_FSID flag makes sense for
> >>>> btrfstune -u|U, where the fsid is changed on each and every tree block,
> >>>> involving many commits. The CHANGING_FSID flag helps to identify the
> >>>> transient incomplete operation.
> >>>>
> >>>> However, for btrfstune -m|M, we don't need the CHANGING_FSID_V2 
> >>>> flag, and
> >>>> a single commit would have been sufficient. The original git commit 
> >>>> that
> >>>> added it, 493dfc9d1fc4 ("btrfs-progs: btrfstune: Add support for 
> >>>> changing
> >>>> the metadata uuid"), provides no reasoning or did I miss something?
> >>>> (So marking this patch as RFC).
> >>>
> >>> I remember discussions with Nikolay about the corner cases that could
> >>> happen due to interrupted conversion and there was a document explaining
> >>> that. Part of that ended up in kernel in the logic to detect partially
> >>> enabled metadata_uuid.  So there was reason to do it in two phases but
> >>> I'd have to look it up in mails or if I still have a link or copy of the
> >>> document.
> >>
> >>
> >> On 18/08/2023 08:21, Qu Wenruo wrote:
> >>
> >>  > Oh, my memory comes back, the original design for the two stage
> >>  > commitment is to avoid split brain cases when one device is committed
> >>  > with the new flag, while the remaining one doesn't.
> >>  >
> >>  > With the extra stage, even if at stage 1 or 2 the transaction is
> >>  > interrupted and only one device got the new flag, it can help us to
> >>  > locate the stage and recover.
> >>
> >> It is useful for `btrfstune -u`
> >> when there are many transaction commits to write. It uses the
> >> `CHANGING_FSID` flag for this purpose. Any device with the
> >> `CHANGING_FSID` flag fails to mount, and `btrfstune` should be called
> >> again to continue rewrite the new FSID. This is a fair process.
> >>
> >>
> >> However, in the case of `CHANGING_FSID_V2`, which the `btrfstune -m` 
> >> command uses, only one transaction is required. How does this help?
> >>
> >>                  Disk1              Disk2
> >>
> >> Commit1     CHANGING_FSID_V2   CHANGING_FSID_V2
> >> Commit2     new-fsid           new-fsid
> >>
> >>
> >>
> > 
> > Instead if there is only one transaction to enable metadata_uuid 
> > feature, we can have the following situation where for the single 
> > transaction we only committed on disk 1:
> > 
> >      Disk 1        Disk 2
> >      Meta uuid    Regular UUID
> > 
> > Then how do kernel/progs proper recover from this situation?
> > 
> > Although I'd say, it's still possible to recover, but significantly more 
> > difficult, as we need to properly handle different generations of super 
> > blocks.
> > 
> > For the two stage one, it's a little simpler but I'm not sure if we have 
> > the extra handling. E.g. if commit 1 failed partially:
> > 
> >      Disk 1            Disk 2
> >      Changing_fsid_v2    no changing_fsid_v2
> > 
> > In this case, we can detects we're trying to start fsid change using 
> > metadata uuid.
> > 
> > The same thing for the 2nd commit.
> 
> 
> 
> The changing_fsid_v2 flag an unnecessary overhead, right? As it could be 
> something like:
> 
>   . Write new-fsid and Verify. Revert if needed and verify.
> 
> 
> ------
> Summarizing the overall patches:
> 
> Patchset [1] is a port of kernel changing_fsid_v2 recovery automation 
> functions to the progs. So, hosts with older progs and can't upgrade to 
> find a tmp host with the newer progs to fix the disks?
> 
>    [1] [PATCH 00/16] btrfs-progs: recover from failed metadata_uuid
> 
> 
> Automation in progs/kernel cannot fix all possible scenarios; we still 
> need user intervention to reunite, as in patchset [2]. It adds --device 
> and --noscan options to reunite. (Needs comments, so that I can rebase).
> 
>    [2] [PATCH 00/10] btrfs-progs: check and tune: add device and noscan 
> options
> 
> 
> Patchset [3] removes the changing_fsid_v2 recovery code from the kernel, 
> as pointed out- recovery code is robust in general, except in corner 
> cases. So, after this, similar to changing_fsid, disks with 
> changing_fsid_v2 are rejected.

Hm I think this is acceptable though degrading the feature a bit. We
can't tell how often the kernel recovery of the metadata_uuid has
happened but fixing all cases there might be too complex, more than it
already is. The whole conversion in btrfstune is quite fast, crashing in
the middle of that is possible but highly unlikely.

We don't have a proper documentation for the metadata_uuid use case,
there are the option and sysfs descriptions but not really how it's
supposed to be used and what to do if setting the metadata_uuid fails.

> But when progs can recover the failed situation and could remove the use 
> of the changing_fsid_v2 flag (patch [4]), we don't actually need the 
> recovery in the kernel.

Ok, let's do it.
