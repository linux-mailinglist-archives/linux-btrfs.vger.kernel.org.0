Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937A635358C
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Apr 2021 23:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236752AbhDCVEu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 3 Apr 2021 17:04:50 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:46869 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236649AbhDCVEt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 3 Apr 2021 17:04:49 -0400
Received: by mail-pf1-f177.google.com with SMTP id x126so746187pfc.13;
        Sat, 03 Apr 2021 14:04:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f4Bo4+ekZ1Lo6D4Hfd5iUOcCNfqkb8+rr7SoEqRdvy8=;
        b=QR7gEjheWsJPKh1gArtznPrI9p/JPNjAgFtxBqf5Pt6nPpeUoWYJrKf6NWRKK5hdJb
         P6BXZ60oxaf6IujRql+G+nv1IDsMfFTnsVpha7ecotBo3Tr1geRBodNqZnpozoIynNZg
         +53JNMfc626dnENpcrbT6E5HhAjMk9+QJm6xVIFPz870jTO8QR9l0wLelBGIniliJiD9
         D/v9kOKi9M5F0Hvb0bsFhS7S+qeAFS6nGQtzy1i7dyaZZS9Jl2virDSD6PPCkmrWex/i
         jqIF+soFOLeiAFOMRJEeAtadpSFoCD2RCqjIFhd8mlVD79iPtgZkUuU+xM/4mCATgCf0
         fw5w==
X-Gm-Message-State: AOAM531o25YtN3y5JYGXMmLTf9LOQyK1ibpFWb1F4pF+PM4213P2slMZ
        yOZoXkEBV+eley1fhesLz20=
X-Google-Smtp-Source: ABdhPJxCe4R6g7Z8RR8kJlmXsjIZsc8jWVvOPDMami32w7eGfQzbCjnCz+8yhIQGqomHrtaDviuEMQ==
X-Received: by 2002:aa7:9532:0:b029:1f8:838e:7773 with SMTP id c18-20020aa795320000b02901f8838e7773mr17219540pfp.15.1617483886229;
        Sat, 03 Apr 2021 14:04:46 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id h1sm11948175pfq.137.2021.04.03.14.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 14:04:45 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 9BC25403EA; Sat,  3 Apr 2021 21:04:44 +0000 (UTC)
Date:   Sat, 3 Apr 2021 21:04:44 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Lukas Middendorf <kernel@tuxforce.de>,
        Greg KH <gregkh@linuxfoundation.org>, dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org, Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: Re: Is request_firmware() really safe to call in resume callback
 when /usr/lib/firmware is on btrfs?
Message-ID: <20210403210444.GU13911@42.do-not-panic.com>
References: <a79f1a0c-012d-bebe-c9c7-b505f59079c2@tuxforce.de>
 <20200817152056.GD4332@42.do-not-panic.com>
 <9e5c716e-1736-9890-54be-75739ea5462f@tuxforce.de>
 <20200818143715.GF4332@42.do-not-panic.com>
 <6b61e549-42b8-8e71-ff57-43b7c5b4291f@tuxforce.de>
 <20210402180253.GS4332@42.do-not-panic.com>
 <CAB=NE6WVnR197DnH+EgHDoyy98x15D0fVdoGjZcHW9W5P7Jipg@mail.gmail.com>
 <CAB=NE6X8bXUoTuTxhy-DDqO8ByaFiJqbjzCSmmGwTbbLY95FhA@mail.gmail.com>
 <679f1f74-1304-9e79-1d83-0810361b4503@tuxforce.de>
 <20210403202538.GW4332@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210403202538.GW4332@42.do-not-panic.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Apr 03, 2021 at 08:25:38PM +0000, Luis Chamberlain wrote:
> So creating say 1000 random files in /lib/firmware on a freshly created
> btrfs partition helps reproduce:
> 
> mkfs.btrfs /dev/whatever
> mount /dev/wahtever /lib/firmware
> # Put it on /etc/fstab too
> 
> Generate 1000 random files on it:
> 
> ```
> for n in {1..1000}; do                                                          
>     dd if=/dev/urandom of=/lib/firmware/file$( printf %03d "$n" ).bin bs=1 count=$((RANDOM + 1024 ))
> done  
> ```
> 
> Then reboot, upon reboot do:
> 
> modprobe test_firmware
> echo 1 > /sys/devices/virtual/misc/test_firmware/config_enable_resume_test
> systemctl suspend

OK this fixes it but this just shows that likely the thaw'ing allows
a race to take place which we didn't expect. I'll do some more digging
for a proper fix.

diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
index 90d255fbdd9b..b9c37eefab35 100644
--- a/fs/kernel_read_file.c
+++ b/fs/kernel_read_file.c
@@ -4,6 +4,7 @@
 #include <linux/kernel_read_file.h>
 #include <linux/security.h>
 #include <linux/vmalloc.h>
+#include <linux/umh.h>
 
 /**
  * kernel_read_file() - read file contents into a kernel buffer
@@ -156,17 +157,25 @@ int kernel_read_file_from_path_initns(const char *path, loff_t offset,
 	if (!path || !*path)
 		return -EINVAL;
 
+	ret = usermodehelper_read_trylock();
+	if (WARN_ON(ret)) {
+		pr_warn_once("Trying to do direct read when not available");
+		return ret;
+	}
 	task_lock(&init_task);
 	get_fs_root(init_task.fs, &root);
 	task_unlock(&init_task);
 
 	file = file_open_root(root.dentry, root.mnt, path, O_RDONLY, 0);
 	path_put(&root);
-	if (IS_ERR(file))
+	if (IS_ERR(file)) {
+		usermodehelper_read_unlock();
 		return PTR_ERR(file);
+	}
 
 	ret = kernel_read_file(file, offset, buf, buf_size, file_size, id);
 	fput(file);
+	usermodehelper_read_unlock();
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kernel_read_file_from_path_initns);
