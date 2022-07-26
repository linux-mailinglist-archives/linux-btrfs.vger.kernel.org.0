Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF885819E4
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 20:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239253AbiGZSnZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jul 2022 14:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbiGZSnY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jul 2022 14:43:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11752D1DC;
        Tue, 26 Jul 2022 11:43:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 57C721F9F3;
        Tue, 26 Jul 2022 18:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658861002;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TTiR4Rj7a7i+4taUmgliJ6Lzey5oIZm0ImPZfCjUCq4=;
        b=wR2cHz/QKkCnntnFSMrNYmBy3J2tl3rYKVEMnA2Z+NfeSrnRb0wD2x+D/FZldcu3vE0Kkp
        JU9U+lSxa8pIkJzJen/lJA8J8bdIrHIfqneBD+6GWORKgwOE85wacfWOYVxCO141VBf6gI
        4+DMmE3O57MLFhB45hqGTN7trd/Wp5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658861002;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TTiR4Rj7a7i+4taUmgliJ6Lzey5oIZm0ImPZfCjUCq4=;
        b=IkzZPx64FXtCcAad35qXVAYOVlbcZqWYCaSRVvzEoG+BX7uF5FdA4wpuQ/xMkDGfSpoJWE
        QvXvjPe75ouPeqDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B9E013322;
        Tue, 26 Jul 2022 18:43:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1x24Bco14GIkIAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 26 Jul 2022 18:43:22 +0000
Date:   Tue, 26 Jul 2022 20:38:24 +0200
From:   David Sterba <dsterba@suse.cz>
To:     hmsjwzb <hmsjwzb@zoho.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, anand.jain@oracle.com,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH]btrfs: Fix fstest case btrfs/219
Message-ID: <20220726183824.GL13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, hmsjwzb <hmsjwzb@zoho.com>,
        Nikolay Borisov <nborisov@suse.com>, anand.jain@oracle.com,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220721083609.5695-1-hmsjwzb@zoho.com>
 <0c2337c3-2b39-c54c-27e9-dd4f0a99cf71@suse.com>
 <1aaff0ac-436e-7782-081c-3549ff3d8c8f@zoho.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1aaff0ac-436e-7782-081c-3549ff3d8c8f@zoho.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 22, 2022 at 01:34:11AM -0400, hmsjwzb wrote:
> On 7/21/22 09:37, Nikolay Borisov wrote:
> > On 21.07.22 г. 11:36 ч., Flint.Wang wrote:
> >> Hi,
> >> fstest btrfs/291 failed.
> >>
> >> [How to reproduce]
> >> mkdir -p /mnt/test/219.mnt
> >> xfs_io -f -c "truncate 256m" /mnt/test/219.img1
> >> mkfs.btrfs /mnt/test/219.img1
> >> cp /mnt/test/219.img1 /mnt/test/219.img2
> >> mount -o loop /mnt/test/219.img1 /mnt/test/219.mnt
> >> umount /mnt/test/219.mnt
> >> losetup -f --show /mnt/test/219.img1 dev
> >> mount /dev/loop0 /mnt/test/219.mnt
> >> umount /mnt/test/219.mnt
> >> mount -o loop /mnt/test/219.img2 /mnt/test/219.mnt
> >>
> >> [Root cause]
> >> if (fs_devices->opened && found_transid < device->generation) {
> >>     /*
> >>      * That is if the FS is _not_ mounted and if you
> >>      * are here, that means there is more than one
> >>      * disk with same uuid and devid.We keep the one
> >>      * with larger generation number or the last-in if
> >>      * generation are equal.
> >>      */
> >>     mutex_unlock(&fs_devices->device_list_mutex);
> >>     return ERR_PTR(-EEXIST);
> >> }
> >>
> >> [Personal opinion]
> >> User might back up a block device to another. I think it is improper
> >> to forbid user from mounting it.
> >>
> >> Signed-off-by: Flint.Wang <hmsjwzb@zoho.com>
> > 
> > 
> > This lacks any explanation whatsoever so it's not possible to judge whether the fix is correct or not.
> > 
> >> ---
> >>   fs/btrfs/volumes.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> >> index 6aa6bc769569a..76af32032ac85 100644
> >> --- a/fs/btrfs/volumes.c
> >> +++ b/fs/btrfs/volumes.c
> >> @@ -900,7 +900,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
> >>            * tracking a problem where systems fail mount by subvolume id
> >>            * when we reject replacement on a mounted FS.
> >>            */
> >> -        if (!fs_devices->opened && found_transid < device->generation) {
> >> +        if (fs_devices->opened && found_transid < device->generation) {
> >>               /*
> >>                * That is if the FS is _not_ mounted and if you
> >>                * are here, that means there is more than one
> 
> Hi Nikolay,
> 
> It seems the failure of btrfs/219 needs some explanation.
> 
> Here is the thing.
>         1. A storage device A with btrfs filesystem is running on a host.
>         2. For example, we backup the device A to an exactly some device B.
>         3. The device A continue to run for a while so the device->generation is getting bigger.
>         4. Then you umount the device A and try to mount device B.
>         5. Kernel find that device A has the same UUID as device B and has bigger device->generation.
>            So the mount request of device B will be rejected.

That's on purpose, devices are matched by UUIDs and making block copies
of the same filesystem is known "don't do that" and discouraged.

If you must store the block copies then you can change the UUID by
btrfstune, there are two ways (fast metadata_uuid, and slow rewriting
all metadata uuids in all blocks).

> 
>             if (!fs_devices->opened && found_transid < device->generation) {
>                  /*
>                   * That is if the FS is _not_ mounted and if you
>                   * are here, that means there is more than one
>                   * disk with same uuid and devid.We keep the one
>                   * with larger generation number or the last-in if
>                   * generation are equal.
>                   */
>                   mutex_unlock(&fs_devices->device_list_mutex);
>                   return ERR_PTR(-EEXIST);
>             }
> 
> I think it is improper to reject that request. Because device A is not in open state.

But this would prevent mounting A. There should really be some way to
distiguish the filesystems, the block device is not a stable identifier,
the UUID is. Imagine having 10 copies of the same filesystem identified
by the same UUID and device UUID, but with different generations and
data. That's asking for problems.

There's not much the filesystem driver can do than to avoid using old
devices and giving preference to the highest generation device. All
devices with btrfs signature are registered in memory and this is the
primary source when mounting the devices, not the block device itself.
