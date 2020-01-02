Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AACB12E8A8
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 17:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgABQYD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 11:24:03 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35607 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbgABQYD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jan 2020 11:24:03 -0500
Received: by mail-qk1-f195.google.com with SMTP id z76so32086348qka.2
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jan 2020 08:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=mfl1wmWB4gCEPqFs2qfDZcYoek3J6epmDA20S+RY4lY=;
        b=cjRZdKQ9IRR7o1lWMsT1XxkF6LgPi6z7PxVCHaRyK4M7/mO5C9PWCobQJHs3P9ISx7
         pYi9olO34LHHF8EY11sqTdeVd74HO9eRuN8tHT3TcqkJelOZ1nsHbAVKjv0p9eD/vUce
         /6Bd1RTUgUe3e00iLfqv+33CtcZ1eSPdknMFklrmqj8tAKJrvnUm9DrTn1wOKDrJtsNX
         YwgnQ6snIEqlhkjfR173bu0YqsSQb83P2OPDte114x4yKYQo10Ctt6wy3tlI736hTSME
         ooMue9dEQgokXCNiDXNY9hPX3LsJIbWLZDQ+yEJUcs8qK85N9EK8S4vAolmEwMqNxN7V
         mVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mfl1wmWB4gCEPqFs2qfDZcYoek3J6epmDA20S+RY4lY=;
        b=oq41jKoJ/X542ijuV4C1TOrwCtfKk8AXYensR9qhaEzOeWEgTNTPac726NdFWLOEfF
         4mOQjDQr3TnqBVlK8ZUU536xy9pf3dFbQ/m/+JoCVvj+qMocqP17XxwYqQVUZHgAIh8o
         DN0Bpc+hp9FtBCbIA0Zk25kGNP9th5thzVe3pr64Neyt+MxhR9XK+n+Sa3vRdpR+f7y/
         fMo/Lj5hAkU1tv4zxBLLKoZZihvOPPvz5Kjw0yR0De9Hyr445HNTONV3TSjhhzvdvs/b
         +V124+VTa5LlUL5/yKIuFZ/Jqcfxa5iWzBapdL42ma73+dIdHOGTlKdUO0Vq3VrBkuJ3
         zwCQ==
X-Gm-Message-State: APjAAAV/rDR6FpKqUrZTVOUSj8Pn8hKQau+pjPA3wM5NEIp4WRPtwK6+
        ExMYnj9z1fqmPpjrrkb2dTfrxT9N0W7Heg==
X-Google-Smtp-Source: APXvYqwB5x0GIAGtPU6e8yJIBRBZK3AXD2i4wpITjbJRpDRxig7Y+WMz1x3KeN+oX+WxmQTK/3G+DA==
X-Received: by 2002:a05:620a:100d:: with SMTP id z13mr69753487qkj.475.1577982241692;
        Thu, 02 Jan 2020 08:24:01 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::be95])
        by smtp.gmail.com with ESMTPSA id 63sm15222854qki.57.2020.01.02.08.24.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2020 08:24:01 -0800 (PST)
Subject: Re: [PATCH v2 1/3] btrfs: add readmirror type framework
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <1577959968-19427-1-git-send-email-anand.jain@oracle.com>
 <1577959968-19427-2-git-send-email-anand.jain@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e6585b93-a585-15e1-ea2a-de6279c317a8@toxicpanda.com>
Date:   Thu, 2 Jan 2020 11:24:00 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1577959968-19427-2-git-send-email-anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/2/20 5:12 AM, Anand Jain wrote:
> As of now we use %pid method to read stripped mirrored data. So
> application's process id determines the stripe id to be read. This type
> of read IO routing typically helps in a system with many small
> independent applications tying to read random data. On the other hand
> the %pid based read IO distribution policy is inefficient if there is a
> single application trying to read large data and the overall disk
> bandwidth remains under utilized.
> 
> So this patch introduces a framework where we could add more readmirror
> policies, such as routing the IO based on device's wait-queue or manual
> when we have a read-preferred device or a policy based on the target
> storage caching.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2: Declare fs_devices::readmirror as u8 instead of atomic_t
>      A small change in comment and change log wordings.
> 
>   fs/btrfs/volumes.c | 16 +++++++++++++++-
>   fs/btrfs/volumes.h |  8 ++++++++
>   2 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index c95e47aa84f8..e26af766f2b9 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1162,6 +1162,8 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
>   	fs_devices->opened = 1;
>   	fs_devices->latest_bdev = latest_dev->bdev;
>   	fs_devices->total_rw_bytes = 0;
> +	/* Set the default readmirror policy */
> +	fs_devices->readmirror = BTRFS_READMIRROR_DEFAULT;
>   out:
>   	return ret;
>   }
> @@ -5300,7 +5302,19 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
>   	else
>   		num_stripes = map->num_stripes;
>   
> -	preferred_mirror = first + current->pid % num_stripes;
> +	switch (fs_info->fs_devices->readmirror) {
> +	case BTRFS_READMIRROR_BY_PID:
> +		preferred_mirror = first + current->pid % num_stripes;
> +		break;
> +	default:
> +		/*
> +		 * Shouln't happen, just warn and use by_pid instead of failing.
> +		 */
> +		btrfs_warn_rl(fs_info,
> +			      "unknown readmirror type %u, fallback to by_pid",
> +			      fs_info->fs_devices->readmirror);
> +		preferred_mirror = first + current->pid % num_stripes;
> +	}
>   
>   	if (dev_replace_is_ongoing &&
>   	    fs_info->dev_replace.cont_reading_from_srcdev_mode ==
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 68021d1ee216..f5f091f3c72b 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -209,6 +209,12 @@ struct btrfs_device {
>   BTRFS_DEVICE_GETSET_FUNCS(disk_total_bytes);
>   BTRFS_DEVICE_GETSET_FUNCS(bytes_used);
>   
> +/* readmirror_policy types */
> +#define BTRFS_READMIRROR_DEFAULT	BTRFS_READMIRROR_BY_PID
> +enum btrfs_readmirror_policy_type {
> +	BTRFS_READMIRROR_BY_PID,
> +};
> +
>   struct btrfs_fs_devices {
>   	u8 fsid[BTRFS_FSID_SIZE]; /* FS specific uuid */
>   	u8 metadata_uuid[BTRFS_FSID_SIZE];
> @@ -260,6 +266,8 @@ struct btrfs_fs_devices {
>   	struct kobject *devices_kobj;
>   	struct kobject *devinfo_kobj;
>   	struct completion kobj_unregister;
> +
> +	u8 readmirror;

The only valid values for this are the enum, so make this

enum btrfs_readmirror_policy_type readmirror;

Thanks,

Josef
