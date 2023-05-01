Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99A16F34E7
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 May 2023 19:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjEARPh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 May 2023 13:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbjEARM2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 1 May 2023 13:12:28 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F09430F5
        for <linux-btrfs@vger.kernel.org>; Mon,  1 May 2023 10:10:45 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id F1F1F5C0191;
        Mon,  1 May 2023 13:09:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 01 May 2023 13:09:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1682960983; x=1683047383; bh=lm
        tk4lYZls9W57+NdYWk4PGDfwOJAd0ADgj53cQXyOs=; b=KODuneQWXzv1aHXGtD
        tI/uwSzAt3PEZQzZCazCfe0sxxWvch3jG9xQezCuXm7imljxuaBxp9Akzp/DNs7A
        N57LsvuU7boChfrHAPoxADlGN1HP3sYB+J0jp11yrrPzQD89XoKKql338MKTC/xb
        RpHuopiULKdF5klp3455WpfxWeHTBNaMvhiGyy/gPXokZSWesJ7NKJQLWMufnh9z
        8Xw480Abm6OdUvRXfSUmypk8cWKpGFO5riIQPCmaEjOjOdZvRwyZQlwAtF8RE4Ir
        FX/iLVz6kkEy2bk3O9QxU7JkZ9q5NoeTzGJr7Yu8XcnOA1VQutQxuAeLOXNDEMwz
        ZVHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682960983; x=1683047383; bh=lmtk4lYZls9W5
        7+NdYWk4PGDfwOJAd0ADgj53cQXyOs=; b=CGPbKHmcYje/LgOIWJtbWu7dKBRgX
        kVQwW2qPqMrsZjz567+mxjcn/S955T13dy1afepj/6hOo/9SO01toERgzVOaRQ5E
        ft0BMNhghRJHpUzQ36ZczxqlEUM3vfqFY/AmCXfOnJsVIfdrDrQbNRtbsbYUOl5F
        AHsFjlRIEst5ecX8h0RNq2byBmSRQjEPIn3jNJospq6UR7AuWklRt8cDxC2YDxlr
        UEExLzWCgC4uZN7884hkAi+2O3iu2QC7v9LogJHIwgTqdaskITAhBvJIybuO58cp
        o4TcIx4lA8/NzQTN0H3Nd7OGctgCZDU7atrZQ+/K5oQ9VUgd+QtvKWQ2w==
X-ME-Sender: <xms:V_JPZMv5qrD9ae_1p7d_mDoaIjto-_YQLOxkGL8ZOtU0AReew0xnFw>
    <xme:V_JPZJfZUm4B9UK4TiBnoXgaoaYbT-xro5sdzaB0BFfI8zz9WejYEubr4UJbtiKCJ
    eyu4BNBoV62eN5YsF4>
X-ME-Received: <xmr:V_JPZHynWOkIGSH8aQ3XySLBWN2UoM_vHQtoTppebSw53f4pBY2njj-G>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvgedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:V_JPZPMjbDThl_E0zoCpGUTuJBS8nM1zWJLDWqqFqKkgNVNBYi6Tcw>
    <xmx:V_JPZM9kn5QAY0ArR0i0W2_Utay54el9d4dwRdYkRXHid29fkJ1Cmg>
    <xmx:V_JPZHWCKm5Py1mEZShiihNkTfkeeIIkjS3lrHdkEuRlOiQ0pV8x6Q>
    <xmx:V_JPZOKc3gf6MsvZlW4YEyKr4twFBnLbViggX_kiuZuzqP7fTUv2mw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 May 2023 13:09:43 -0400 (EDT)
Date:   Mon, 1 May 2023 10:09:30 -0700
From:   Boris Burkov <boris@bur.io>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        'Qu Wenruo ' <wqu@suse.com>
Subject: Re: [PATCH RFC] btrfs: fix qgroup rsv leak in subvol create
Message-ID: <20230501170930.GB3094799@zen>
References: <c98e812cb4e190828dd3cdcbd8814c251233e5ca.1682723191.git.boris@bur.io>
 <23f9b436-223c-918c-a3fd-290c3ac3bd7e@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23f9b436-223c-918c-a3fd-290c3ac3bd7e@gmx.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Apr 29, 2023 at 03:18:26PM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/4/29 07:08, Boris Burkov wrote:
> > While working on testing my quota work, I tried running all fstests
> > while passing mkfs -R quota. That shook out a failure in btrfs/042.
> > 
> > The failure is a reservation leak detected at umount, and the cause is a
> > subtle difficulty with the qgroup rsv release accounting for inode
> > creation.
> 
> Mind to give an example of the leakage kernel error message?
> As such message would include the type of the rsv.

Sorry, missed this question in my first reply. The leaked rsv is the
PREALLOC reserved in subvolume creation in
btrfs_subvolume_reserve_metadata. Normally, that gets converted to
PERTRANS by btrfs_subvolume_release_metadata and released per trans, but
the bug we are hitting now is that before we call
btrfs_subvolume_release_metadata, we make the following sequence of
calls:

btrfs_create_new_inode
btrfs_add_link
btrfs_insert_dir_item
btrfs_insert_delayed_dir_index

and in that call, reserve_leaf_space computes to false, because we are
in an ongoing transaction and the node we are working on has enough
room, so we call

btrfs_block_rsv_release which destroys the qgroup rsv accounting without
tracking/returning it (since the ret variable was passed in NULL)

Then when we get to btrfs_subvolume_release_metadata, the qgroup rsv
accounting is messed up and we don't convert/release it there either.

My "fix" does the conversion here halfway in to the transaction, but
that feels quite wrong. Perhaps the better fix is something like not
blowing up the qgroup reserved in block_rsv_release_bytes if the qgroup
return pointer isn't passed in?

TL;DR, the type is BTRFS_QGROUP_RSV_META_PREALLOC and the trace is

[   19.328967] BTRFS warning (device dm-1): qgroup 0/5 has unreleased space, type 2 rsv 311296
[   19.329444] ------------[ cut here ]------------
[   19.329687] WARNING: CPU: 0 PID: 983 at fs/btrfs/disk-io.c:4592 close_ctree+0x4ac/0x550 [btrfs]
[   19.330209] Modules linked in: virtio_net btrfs xor zstd_compress raid6_pq null_blk
[   19.330604] CPU: 0 PID: 983 Comm: umount Kdump: loaded Not tainted 6.3.0-rc7+ #25
[   19.330987] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.2-1-1 04/01/2014
[   19.331480] RIP: 0010:close_ctree+0x4ac/0x550 [btrfs]
[   19.331789] Code: ba 02 00 00 00 4c 89 f6 48 89 df e8 ae c4 ae d2 8b 85 08 07 00 00 85 c0 75 e1 4c 89 f6 48 89 df e8 29 b0 ae d2 e9 f6 fb ff ff <0f> 0b 48 c7 c6 68 f0 77 c0 48 89 ef e8 03 81 0b 00 e9 98 fc ff ff
[   19.332743] RSP: 0018:ffffb4cec143fde8 EFLAGS: 00010202
[   19.333014] RAX: 0000000000000001 RBX: ffff9edec2deaba8 RCX: 0000000000000001
[   19.333392] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff9edec26d7798
[   19.333763] RBP: ffff9edec2dea000 R08: 00000000ffffdfff R09: 00000000ffffdfff
[   19.334129] R10: ffffffff95073020 R11: ffffffff95073020 R12: ffff9edec45494cc
[   19.334506] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   19.334874] FS:  00007f1297878b80(0000) GS:ffff9ee1efc00000(0000) knlGS:0000000000000000
[   19.335301] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   19.335598] CR2: 0000555ffa9d99f8 CR3: 0000000107e90000 CR4: 00000000000006f0
[   19.335964] Call Trace:
[   19.336098]  <TASK>
[   19.336228]  ? fsnotify_sb_delete+0x144/0x1d0
[   19.336462]  ? evict_inodes+0x181/0x210
[   19.336665]  generic_shutdown_super+0x69/0x190
[   19.336910]  kill_anon_super+0x14/0x30
[   19.337110]  btrfs_kill_super+0x12/0x20 [btrfs]
[   19.337417]  deactivate_locked_super+0x2f/0x80
[   19.337650]  cleanup_mnt+0xbd/0x150
[   19.337836]  task_work_run+0x59/0x90
[   19.338027]  exit_to_user_mode_prepare+0x10f/0x120
[   19.338292]  syscall_exit_to_user_mode+0x1d/0x40
[   19.338536]  do_syscall_64+0x46/0x90
[   19.338727]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   19.338991] RIP: 0033:0x7f12979da9e7
[   19.339193] Code: 3f 04 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 09 04 0d 00 f7 d8 64 89 02 b8
[   19.340132] RSP: 002b:00007fffa74c1288 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
[   19.340537] RAX: 0000000000000000 RBX: 0000555ffa9cd518 RCX: 00007f12979da9e7
[   19.340903] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000555ffa9d1710
[   19.341280] RBP: 0000000000000000 R08: 0000555ffa9d14f0 R09: 0000555ffa9d16b0
[   19.341645] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f1297b18264
[   19.342010] R13: 0000555ffa9d1710 R14: 0000555ffa9cd630 R15: 0000555ffa9cd400
[   19.342388]  </TASK>
[   19.342508] ---[ end trace 0000000000000000 ]---

> 
> > 
> > The issue stems from a recent change to subvol creation:
> > btrfs: don't commit transaction for every subvol create
> > 
> > Specifically, that test creates 10 subvols, and in the mode where we
> > commit each time, the logic for dir index item reservation never decides
> > that it can undo the reservation. However, if we keep joining the
> > previous transaction, this logic kicks in and calls
> > btrfs_block_rsv_release without specifying any of the qgroup release
> > return counter stuff. As a result, adding the new subvol inode blows
> > away the state needed for the later explicit call to
> > btrfs_subvolume_release_metadata.
> 
> Is there any reproducer for it?
> 
> By the description it should be pretty simple as long as we create multiple
> subvolumes in one transaction.
> 
> I'd like to have some qgroup related trace enabled to show the problem more
> explicitly, as I'm not that familiar with the delayed inode code.
> 
> Thanks,
> Qu
> > 
> > I suspect this fix is incorrect and will break something to do with
> > normal inode creation, but it's an interesting starting point and I
> > would appreciate any suggestions or help with how to really fix it,
> > without reverting the subvol commit patch. Worst case, I suppose we can
> > commit every time if quotas are enabled.
> > 
> > The issue should reproduce on misc-next on btrfs/042 with
> > MKFS_OPTIONS="-K -R quota"
> > in the config file.
> > 
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >   fs/btrfs/delayed-inode.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> > index 6b457b010cbc..82b2e86f9bd9 100644
> > --- a/fs/btrfs/delayed-inode.c
> > +++ b/fs/btrfs/delayed-inode.c
> > @@ -1480,6 +1480,7 @@ int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
> >   		delayed_node->index_item_leaves++;
> >   	} else if (!test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags)) {
> >   		const u64 bytes = btrfs_calc_insert_metadata_size(fs_info, 1);
> > +		u64 qgroup_to_release;
> >   		/*
> >   		 * Adding the new dir index item does not require touching another
> > @@ -1490,7 +1491,8 @@ int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
> >   		 */
> >   		trace_btrfs_space_reservation(fs_info, "transaction",
> >   					      trans->transid, bytes, 0);
> > -		btrfs_block_rsv_release(fs_info, trans->block_rsv, bytes, NULL);
> > +		btrfs_block_rsv_release(fs_info, trans->block_rsv, bytes, &qgroup_to_release);
> > +		btrfs_qgroup_convert_reserved_meta(delayed_node->root, qgroup_to_release);
> >   		ASSERT(trans->bytes_reserved >= bytes);
> >   		trans->bytes_reserved -= bytes;
> >   	}
