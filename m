Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C079232396
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jul 2020 19:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgG2RnH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jul 2020 13:43:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34002 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726336AbgG2RnH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jul 2020 13:43:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596044586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SvxZklvS7btlYmJ52uzMyCTyCwZPd6bDgIs8VYsVzrA=;
        b=Ic9yZyRUj0U+aIb+O+m44RbMZHuV2Z5ks1ay1BymngRqhmtlt9uLVnplNc6IpA/4iCQLxk
        1IJafKnNOIh4cH0Vo4DUitao0J2l+P90BROojkc/2DsHncAT4Fbi5YYGM12mLfjbwemuiQ
        k3wwR2T9ksfDeMUMiDx+73TuNYLy5M8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-TsN-0OqJPn2VjAoDltLWNg-1; Wed, 29 Jul 2020 13:43:02 -0400
X-MC-Unique: TsN-0OqJPn2VjAoDltLWNg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8FED18C63C1;
        Wed, 29 Jul 2020 17:43:00 +0000 (UTC)
Received: from Liberator.local (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C15710013D0;
        Wed, 29 Jul 2020 17:43:00 +0000 (UTC)
Subject: Re: [PATCH] btrfs: indicate iversion option in show_options
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200729164656.7153-1-josef@toxicpanda.com>
From:   Eric Sandeen <sandeen@redhat.com>
Message-ID: <48ad9fc0-dbdd-60f3-c1ab-f0152f6e3230@redhat.com>
Date:   Wed, 29 Jul 2020 10:42:59 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200729164656.7153-1-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/29/20 9:46 AM, Josef Bacik wrote:
> Eric reported a problem where if you did
> 
> mount -o remount /some/btrfs/fs
> 
> you would lose SB_I_VERSION on the mountpoint.  After a very convoluted
> search I discovered this is because the remount infrastructure doesn't
> just say "change these things specifically", but it actually depends on
> userspace to tell it fucking everything that needs to be set on the
> mountpoint.  This led to the fucking horrifying discovery that
> util-linux actually has to parse /proc/mounts to figure out what the
> fuck is set on the mount point in order to preserve any of the options
> it's not actually fucking with, so in this case iversion.  If we don't
> indicate iversion is set, then we get iversion cleared on the mount,
> because util-linux doesn't pass in MS_I_VERSION as it's mount flags.
> 
> So work around this fucking insanity by spitting out iversion in
> /proc/mounts so we get the correct flags passed to us in remount.

Hmmm:

# mount -o loop,noiversion btrfsfile mnt
# grep btrfs /proc/mounts
/dev/loop0 /tmp/mnt btrfs rw,seclabel,relatime,iversion,space_cache,subvolid=5,subvol=/ 0 0
#

> Reported-by: Eric Sandeen <sandeen@redhat.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/super.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index aa73422b0678..fe64aa2f5c7a 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -1427,6 +1427,10 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
>  		seq_puts(seq, ",discard=async");
>  	if (!(info->sb->s_flags & SB_POSIXACL))
>  		seq_puts(seq, ",noacl");
> +	if (info->sb->s_flags & SB_I_VERSION)
> +		seq_puts(seq, ",iversion");
> +	else
> +		seq_puts(seq, ",noiversion");
>  	if (btrfs_test_opt(info, SPACE_CACHE))
>  		seq_puts(seq, ",space_cache");
>  	else if (btrfs_test_opt(info, FREE_SPACE_TREE))
> 

