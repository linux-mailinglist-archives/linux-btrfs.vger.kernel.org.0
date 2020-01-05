Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70E3C130975
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jan 2020 19:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgAESvA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Jan 2020 13:51:00 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43748 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgAESvA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Jan 2020 13:51:00 -0500
Received: by mail-wr1-f67.google.com with SMTP id d16so47298138wre.10
        for <linux-btrfs@vger.kernel.org>; Sun, 05 Jan 2020 10:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YvKGiPwUw63BrfDDcgutkM+CXxoR+RfTWOHoElHWDPs=;
        b=qtnzuBAYhOo0WAFYY6n2CPjimRSDOQdSrTRlMEHwVcIaCnUGPeVTBAwtcnZCWjbiHi
         HxtvvgTyDfFannlTNaonb9S1Vzih3qn5Z0W/bQKqDNJIq/r4Bz6izD6QSWLI4FBN7DTp
         JZtnt6oKH3BKnUKGh8quTsNCnWvKcVZlCqMJD/Now8XSJayrA+pMqPvMgUkawzRbusbo
         FUvy8xlBRHM2ehZ7u324lpadDvengUDOlWjFtjizoczE4aFO/7bedmk/o949yCunNU6w
         oxPXGtl3vVRaHXXmpM9diW22k0fgNlQx6zWh4vYLp2RvwxpwJcu8ZV+Pb3FQ7N6V+mO2
         K2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YvKGiPwUw63BrfDDcgutkM+CXxoR+RfTWOHoElHWDPs=;
        b=TdpqJ7xIiHYozoaaQvNNSh55gUhKBxV/F6y8lX5o2TRJ9MHRucgxglO8j45UbNv06g
         4PFAcso+6WayATxg8XrcV5V7QT9U55zg9oQKpUwDA25oCKtKAWHeQkm0bUl56nXihW8S
         vydgcPEBfGQ8Kh8PcyfqQPkYGnTtEbV4kiYItj3wWtAyT5KN1ZrnJqdawOBDiNYvqqjE
         W8TxwIvpZYC4bDT49I3O8a7ay8WNNm6c+6Oh/GZTz1+PZLHUaWZdLi/JAYilbnoKPMat
         CWtwW4RDoXzcXHa07mTYK3nToen2VmNTqCUVCWwu0IAiRbmQe/ZqZp6Eklw5zkxp3FSB
         RGMw==
X-Gm-Message-State: APjAAAWDw5OYXJy2JfqVh+l7HrmUC6CSg7Kd8tTO/9qxCa/zw+FTaj0s
        psQIpa7lzZ8+qdx5TfsQIbWFWDXeEtpHrwQuzx3hew==
X-Google-Smtp-Source: APXvYqy/M1vnZS3h2B91FFPnFtVtkL9Px2WYLJaLiy+qdELAiL2oLSfGmDCSCy7605ErdbLDF8/GtUelUWLOUxSu0+o=
X-Received: by 2002:adf:e6d2:: with SMTP id y18mr102553967wrm.262.1578250257929;
 Sun, 05 Jan 2020 10:50:57 -0800 (PST)
MIME-Version: 1.0
References: <20191206034406.40167-1-wqu@suse.com> <2a220d44-fb44-66cf-9414-f1d0792a5d4f@oracle.com>
 <762365A0-8BDF-454B-ABA9-AB2F0C958106@icloud.com> <94a6d1b2-ae32-5564-22ee-6982e952b100@suse.com>
 <4C0C9689-3ECF-4DF7-9F7E-734B6484AA63@icloud.com> <f7fe057d-adc1-ace5-03b3-0f0e608d68a3@gmx.com>
 <9FB359ED-EAD4-41DD-B846-1422F2DC4242@icloud.com> <256D0504-6AEE-4A0E-9C62-CDF975FDE32D@icloud.com>
 <e04d1937-d70c-c891-4eea-c6fb70a45ab5@gmx.com> <8B00108E-4450-4448-8663-E5A5C0343E26@icloud.com>
In-Reply-To: <8B00108E-4450-4448-8663-E5A5C0343E26@icloud.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 5 Jan 2020 11:50:42 -0700
Message-ID: <CAJCQCtQAFRdutyVOt7JALtVsn-EeXhzNYYjdKpmS1Ts_6-6nMA@mail.gmail.com>
Subject: Re: 12 TB btrfs file system on virtual machine broke again
To:     Christian Wimmer <telefonchris@icloud.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu WenRuo <wqu@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 5, 2020 at 7:17 AM Christian Wimmer <telefonchris@icloud.com> wrote:
>
> Seems that I am using fstrim (I did not know this, what is it?):

Frees unused blocks from underlying storage: in the case of sparse
files it punches holds, for thin provisioning it frees logical extents
back to the pool, and for real physical SSDs it informs the firmware
those blocks are no longer used and can be garbage collected.

Most bugs in this area have either been fixed by firmware updates by
manufacturers for the SSD, or they've been blacklisted in the kernel
so that FITRIM is a no op.


>
> BTW, sda2 is here my root partition which is practically the same configuration (just smaller) than the 12TB hard disc
>
> 2020-01-03T11:30:47.479028-03:00 linux-ze6w kernel: [1297857.324177] sda2: rw=2051, want=532656128, limit=419430400
> 2020-01-03T11:30:47.479538-03:00 linux-ze6w kernel: [1297857.324658] BTRFS warning (device sda2): failed to trim 1 device(s), last error -5
> 2020-01-03T11:30:48.376543-03:00 linux-ze6w fstrim[27910]: fstrim: /opt: FITRIM ioctl failed: Input/output error
> 2020-01-03T11:30:48.378998-03:00 linux-ze6w kernel: [1297858.223675] attempt to access beyond end of device
> 2020-01-03T11:30:48.379012-03:00 linux-ze6w kernel: [1297858.223677] sda2: rw=3, want=421570540, limit=419430400

Yeah that's a problem. That may not be *the* problem, but there is
confusion here. What is /dev/sda? This is a virtual drive inside the
guest VM? And is backed by a file on the Promise storage? What about
/dev/sdb? Same thing? You're only having a problem with /dev/sdb,
which contains a Btrfs file system. But if its storage stack is the
same as /dev/sda, then the FITRIM problem might be related, we just
don't have logs proving it.

What do you get for 'sudo systemctl status fstrim.timer' ?

While it might be simple to just disable the fstrim.timer if it's
enabled; I don't know that this tells you whether there might be other
problems with the storage stack somewhere. The fact that this
particular FITRIM command is trying to access beyond the end of the
device, means there is confusion about /dev/sda size. Is that
transient and related to the resize maybe not yet having completed? Or
is it a persistent problem that could affect the mapping in otherwise
valid regions inside this virtual block device?

What should be true is FITRIM inside a guest VM either completely
fails (unmap or trim are not advertised and therefore FITRIM fails
safely) or it completely succeeds. You shouldn't get corruptions and
you shouldn't get the message you're seeing. So my advice is trying to
figure out why that's happening. And also if logs show whether it has
ever happened for /dev/sdb




-- 
Chris Murphy
