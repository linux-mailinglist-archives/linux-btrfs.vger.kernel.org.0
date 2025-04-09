Return-Path: <linux-btrfs+bounces-12926-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 808CAA82D11
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 19:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C98321B67A84
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 17:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3C0270EB9;
	Wed,  9 Apr 2025 16:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBm3YMKq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B58F270EBD
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Apr 2025 16:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744217983; cv=none; b=OA9+47Ysr5d9RCvnxqGmEFWmtQrYWKe+84KIiiCylgM7N7nvePu1wVdGujXabhZFZ1MscbNsfbyE7buGRjf6ZzZYcL66kcRUfPTz8yIfEzGFN1woeHrP3LrFkDLT2TeYY2Me0SMI8YzvbieSpMslvfkCF/x4EtQedK3KhbDrmWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744217983; c=relaxed/simple;
	bh=qjtX8SGPZgkXIl3P4n9Xl09oGeUNRfG6wUcw2wZ4mu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EEUu+jy4l+TBkGzsQzQRlE6ctelrA7DYn007JOUmwN2PnMDiu3bOiQXE53IaaTABy6OF5iABn/pOKDxmzvUmNDWywO1RkhNGkqO9KK45ME41K8/Qoi6LbILmkH1Lqw7zz1phEzz9ewOu19+Sj5oYp53GjOh6M/3EHi3fN6epc2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBm3YMKq; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c53b9d66fdso895208485a.3
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Apr 2025 09:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744217980; x=1744822780; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zKk16v04icy2pY8FO0EcuPp51s8CM/7qdrMU99rlKeY=;
        b=MBm3YMKqK0ao+mEEVuf2F4y8zrUgGq4bASMdhFL557KP8/KtcWAwLaOQFMAeF/wc30
         kX8l463tTPhXmyn4Pni+vQqBUVQgs3Dfud++6pQHTIbLIGMRwpJROl0NqUVxUabKu3ax
         dzTsXqY+/1LG0VhZiwFuRt+5kn8bNOdED8/Mutn5ucpD4JREEmKqj8/8Q7GmZyxQwyl7
         6Q65xeMo82GJzahSmQFpy74/L6qckOTOjT+qF98vCIElqU3Saut7d8xWiviQXb5QrEJz
         p8J9e1yMRAS4ryPjPBTNAGZ291Mo0JLYYYz3AQ/NZtPs9iDWJHjnZ3aJZzO0Sl3rIDQk
         uBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744217980; x=1744822780;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zKk16v04icy2pY8FO0EcuPp51s8CM/7qdrMU99rlKeY=;
        b=YaApj6OFma/PYQNaz46gpz9sNbDJ6EuMXbjmq69lxk9e+k73yRc/e/Ap41XsljvaBn
         byzKe35AY7dPlvjs27wjT0EATcuGfv6qRWFkBu5C+q04qCpFyMQM6pY9nlX6eNljlc+T
         QdZFlEzhfnRHpq1mdbWXClVVlKM4eRkSsHAeEB0JcBXAySF6Cm5rPmUw25O3O6bcyDt2
         jjVd7ivOxMHs4TvQZVP/VBUvbBcrJoqBPGHBUMRHpR1wUWabMRmg5fE8BG2pe9h+QD3J
         ivQV2TzQmy5AG/DbKv4x5vlP9bQ7HAcCFagYOyITQIIfFUY+EqD08OK8CBlJ7xVxIJk0
         enJA==
X-Gm-Message-State: AOJu0YwJd2eu1+BX6VlqrSIr1BlYULyjj4UgV0onFPpZCpRtpeINtIna
	Max+dxaFwsj0FJnDnez3Yh7cbRJJr86BwbYMOkNYXtV+y8/Q/E+nBprSVBQvjOyADK6tER5z+9k
	SZfZ8pW55lwowOJU1jcJfRxj31lA=
X-Gm-Gg: ASbGncv8tcmvcjFlzh3gY/nTUgEfFlPPmx5Jg+kx5yU+FB5++whHFiTDYkKZiOhZKGj
	K2ehtrMrtWL11OV4prIHEz6KSxJpVhH7GHV+PyyCQ4gNzaDPQ/b4mwN4dF4cCK1XHacPogry2bh
	gyGNfWQoIWEJibvaqAjhRHhPK50uyCJSTljEyWsB3/rcAZhBp2yjJ2xbA=
X-Google-Smtp-Source: AGHT+IHFhASs0RjhPqxSI+4k5F+VoyhGOTtXRCaNAR4Dzt+PsPfPbdbeE08BEEuDd7UmAM/kaYp+NafBWOQPNGAM3U0=
X-Received: by 2002:a05:622a:1115:b0:476:6b20:2cef with SMTP id
 d75a77b69052e-47960134f73mr51729851cf.41.1744217979832; Wed, 09 Apr 2025
 09:59:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1735748715.git.anand.jain@oracle.com> <0878345c55203627eb5dcf0e29d5101c29f49c6b.1735748715.git.anand.jain@oracle.com>
In-Reply-To: <0878345c55203627eb5dcf0e29d5101c29f49c6b.1735748715.git.anand.jain@oracle.com>
From: Kai Krakow <hurikhan77+btrfs@gmail.com>
Date: Wed, 9 Apr 2025 18:59:13 +0200
X-Gm-Features: ATxdqUFsZaMomQo8NKAVBDTfY-LkvTLoJ-pyJpp0UDKfEroeJlxyzggRovRFvB8
Message-ID: <CAMthOuMQnDta-4Uo98CNsvL0Xkp77K8TDfEvirUnBjkJqVwptQ@mail.gmail.com>
Subject: Re: [PATCH v5 09/10] btrfs: enable RAID1 balancing configuration via
 modprobe parameter
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com, Naohiro.Aota@wdc.com, 
	wqu@suse.com, hrx@bupt.moe, waxhead@dirtcellar.net
Content-Type: text/plain; charset="UTF-8"

Hi Anand!

Am Mi., 1. Jan. 2025 um 19:10 Uhr schrieb Anand Jain <anand.jain@oracle.com>:
>
> This update allows configuring the `raid1-balancing` methods using a
> modprobe parameter when experimental mode CONFIG_BTRFS_EXPERIMENTAL
> is enabled.
>
> Examples:
>
> - Set the RAID1 balancing method to round-robin with a custom
> `min_contiguous_read` of 4k:
>   $ modprobe btrfs raid1-balancing=round-robin:4096
>
> - Set the round-robin balancing method with the default
> `min_contiguous_read`:
>   $ modprobe btrfs raid1-balancing=round-robin
>
> - Set the `devid` balancing method, defaulting to the latest
> device:
>   $ modprobe btrfs raid1-balancing=devid
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/super.c   |  5 +++++
>  fs/btrfs/sysfs.c   | 30 +++++++++++++++++++++++++++++-
>  fs/btrfs/sysfs.h   |  5 +++++
>  fs/btrfs/volumes.c | 14 +++++++++++++-
>  4 files changed, 52 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index fb6a009c72ae..58190989a29d 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2538,6 +2538,11 @@ static const struct init_sequence mod_init_seq[] = {
>         }, {
>                 .init_func = extent_map_init,
>                 .exit_func = extent_map_exit,
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
> +       }, {
> +               .init_func = btrfs_raid1_balancing_init,
> +               .exit_func = NULL,
> +#endif
>         }, {
>                 .init_func = ordered_data_init,
>                 .exit_func = ordered_data_exit,
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index eb23f29995e4..ac1a32af2442 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -1313,7 +1313,21 @@ static const char *btrfs_read_policy_name[] = {
>  #endif
>  };
>
> -static int btrfs_read_policy_to_enum(const char *str, s64 *value)
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
> +/* Global module configuration parameters */
> +static char *raid1_balancing;
> +char *btrfs_get_raid1_balancing(void)
> +{
> +       return raid1_balancing;
> +}
> +
> +/* Set perm 0, disable sys/module/btrfs/parameter/raid1_balancing interface */
> +module_param(raid1_balancing, charp, 0);
> +MODULE_PARM_DESC(raid1_balancing,
> +"Global read policy; pid (default), round-robin[:min_contiguous_read], devid[[:devid]|[:latest-gen]|[:oldest-gen]]");

I don't see where "[:latest-gen]|[:oldest-gen]" would be used in the code.

> +#endif
> +
> +int btrfs_read_policy_to_enum(const char *str, s64 *value)
>  {
>         char param[32] = {'\0'};
>         char *__maybe_unused value_str;
> @@ -1336,6 +1350,20 @@ static int btrfs_read_policy_to_enum(const char *str, s64 *value)
>         return sysfs_match_string(btrfs_read_policy_name, param);
>  }
>
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
> +int __init btrfs_raid1_balancing_init(void)
> +{
> +       s64 value;
> +
> +       if (btrfs_read_policy_to_enum(raid1_balancing, &value) == -EINVAL) {
> +               btrfs_err(NULL, "Invalid raid1_balancing %s", raid1_balancing);
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +#endif
> +
>  static ssize_t btrfs_read_policy_show(struct kobject *kobj,
>                                       struct kobj_attribute *a, char *buf)
>  {
> diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
> index e6a284c59809..e97d383b9ffc 100644
> --- a/fs/btrfs/sysfs.h
> +++ b/fs/btrfs/sysfs.h
> @@ -47,5 +47,10 @@ void btrfs_sysfs_del_qgroups(struct btrfs_fs_info *fs_info);
>  int btrfs_sysfs_add_qgroups(struct btrfs_fs_info *fs_info);
>  void btrfs_sysfs_del_one_qgroup(struct btrfs_fs_info *fs_info,
>                                 struct btrfs_qgroup *qgroup);
> +int btrfs_read_policy_to_enum(const char *str, s64 *value);
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
> +int __init btrfs_raid1_balancing_init(void);
> +char *btrfs_get_raid1_balancing(void);
> +#endif
>
>  #endif
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index e8cccfad6ad3..e5e9b33837b8 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1299,6 +1299,7 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
>         struct btrfs_device *device;
>         struct btrfs_device *latest_dev = NULL;
>         struct btrfs_device *tmp_device;
> +       s64 __maybe_unused value = 0;
>         int ret = 0;
>
>         /* Initialize the in-memory record of filesystem read count */
> @@ -1333,10 +1334,21 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
>         fs_devices->latest_dev = latest_dev;
>         fs_devices->total_rw_bytes = 0;
>         fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_REGULAR;
> -       fs_devices->read_policy = BTRFS_READ_POLICY_PID;
>  #ifdef CONFIG_BTRFS_EXPERIMENTAL
>         fs_devices->rr_min_contiguous_read = BTRFS_DEFAULT_RR_MIN_CONTIGUOUS_READ;
>         fs_devices->read_devid = latest_dev->devid;
> +       fs_devices->read_policy =
> +               btrfs_read_policy_to_enum(btrfs_get_raid1_balancing(), &value);
> +       if (fs_devices->read_policy == BTRFS_READ_POLICY_RR)
> +               fs_devices->fs_stats = true;
> +       if (value) {
> +               if (fs_devices->read_policy == BTRFS_READ_POLICY_RR)
> +                       fs_devices->rr_min_contiguous_read = value;
> +               if (fs_devices->read_policy == BTRFS_READ_POLICY_DEVID)
> +                       fs_devices->read_devid = value;
> +       }
> +#else
> +       fs_devices->read_policy = BTRFS_READ_POLICY_PID;
>  #endif
>
>         return 0;
> --
> 2.47.0

Thanks
Kai

