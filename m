Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDDE1309E4
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jan 2020 21:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgAEUfP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Jan 2020 15:35:15 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:43989 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgAEUfP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Jan 2020 15:35:15 -0500
Received: by mail-wr1-f45.google.com with SMTP id d16so47514436wre.10
        for <linux-btrfs@vger.kernel.org>; Sun, 05 Jan 2020 12:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K+uIZ7CBhm75D4Zcs/f7k6un0pDFC2ugry7KqbHSdMQ=;
        b=IQmvg7DzL+jJ2dyy5Lla08Ip0rG2YC/quz8OoLs4YLsnvoFP3SSPwh/s0hXuG4T5Zh
         DbZzpSgmNPhOXoF6cZTXEJJPAOIztr6ZRCs+R+Lo3EnULA/Y/9jRr+dCugygYID2jpzk
         7BCGe2MnKc6W7pMOCkeGDJCTftZpTKClkmyfGhOtRzXg+QsCXCoyDhIjpy4UCOMpAbJU
         kps/0PkbIWsc32wIPJi4Xg7e4c4Rj4YQE4ALq3+Aena0xN8H0oR+gBUlRB27tNf1ehVi
         VhtogS92mHN42FNLfHOksUdEUnPEIc40pp7dLvqECyW8QivKzGttIDwwoYD/VBd4f9w1
         LqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K+uIZ7CBhm75D4Zcs/f7k6un0pDFC2ugry7KqbHSdMQ=;
        b=lRqVKL+kfqX5VpuUqQdXomE7ZuSftzH5LgcCXQltNBRpsXID2EL1/U8dGoITI4mcAd
         oTm+uoYlhGS/EIlN5WOd6bz1kXjGueFVoNJsqnfjxBFExCf3uYeTadpl4umEHgCFpdWF
         Cdq9h7u0sT7cApg33gJbSIQ0/R4qU2n4AxygsTludtFMZttkotwwqHgGKbGS4cgZl4jN
         jBenL0NFdaGWp4KtqG0jSTxFo4nPi49aLMc1LauaK4yXJ3RZzlzkxS3ZgQ+L2nSoPIZT
         XkgsgXZy0h7kGgQymSUBCb9IeR0Jb+W4OyshiaG+tyxVU2OwXvtJHGM4ntpLBRs/BqkT
         JFnA==
X-Gm-Message-State: APjAAAWMD/sYdZcczeWBNLFkVxLeC6QlZD0B5iQM7ghK4ETFOgQ/lk62
        taXv8XzTWqoDMubYNdME6Zk9uOvufORcpkk3wrBdVA==
X-Google-Smtp-Source: APXvYqyYMChLYnjUdzmbgL+MitlNHRn2cObCHoJjudXCFfBsb2LHXw6hfJLwS1PXHC91cGEqxelpipLdDvTM3aBaVDI=
X-Received: by 2002:adf:ea4e:: with SMTP id j14mr102817610wrn.101.1578256512456;
 Sun, 05 Jan 2020 12:35:12 -0800 (PST)
MIME-Version: 1.0
References: <20191206034406.40167-1-wqu@suse.com> <2a220d44-fb44-66cf-9414-f1d0792a5d4f@oracle.com>
 <762365A0-8BDF-454B-ABA9-AB2F0C958106@icloud.com> <94a6d1b2-ae32-5564-22ee-6982e952b100@suse.com>
 <4C0C9689-3ECF-4DF7-9F7E-734B6484AA63@icloud.com> <f7fe057d-adc1-ace5-03b3-0f0e608d68a3@gmx.com>
 <9FB359ED-EAD4-41DD-B846-1422F2DC4242@icloud.com> <256D0504-6AEE-4A0E-9C62-CDF975FDE32D@icloud.com>
 <e04d1937-d70c-c891-4eea-c6fb70a45ab5@gmx.com> <8B00108E-4450-4448-8663-E5A5C0343E26@icloud.com>
 <CAJCQCtQAFRdutyVOt7JALtVsn-EeXhzNYYjdKpmS1Ts_6-6nMA@mail.gmail.com>
 <CC877460-A434-408F-B47D-5FAD0B03518C@icloud.com> <CAJCQCtS+a2WU01QCHXycLT8ktca-XV5JkO-KwtjRRzeEa4xikQ@mail.gmail.com>
 <BF92D4FB-0FBF-49F8-A32D-60D56C41AAEC@icloud.com>
In-Reply-To: <BF92D4FB-0FBF-49F8-A32D-60D56C41AAEC@icloud.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 5 Jan 2020 13:34:56 -0700
Message-ID: <CAJCQCtSXjqxuo2jNJfJ8z_tqsE53ueJyEcOG54fPrPQiYT4vLg@mail.gmail.com>
Subject: Re: 12 TB btrfs file system on virtual machine broke again
To:     Christian Wimmer <telefonchris@icloud.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu WenRuo <wqu@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 5, 2020 at 12:52 PM Christian Wimmer
<telefonchris@icloud.com> wrote:
>
> BTW, I found this messages in the messages-20200105 file:
>
>
>
> bash$ grep fstrim messages-20200105
> 2019-12-23T00:00:03.533050-03:00 linux-ze6w fstrim[32008]: fstrim: /boot/grub2/i386-pc: FITRIM ioctl failed: Input/output error
> 2019-12-23T00:00:04.354989-03:00 linux-ze6w fstrim[32008]: fstrim: /boot/grub2/x86_64-efi: FITRIM ioctl failed: Input/output error
> 2019-12-23T00:00:05.149687-03:00 linux-ze6w fstrim[32008]: fstrim: /home: FITRIM ioctl failed: Input/output error
> 2019-12-23T00:00:05.941978-03:00 linux-ze6w fstrim[32008]: fstrim: /opt: FITRIM ioctl failed: Input/output error
> 2019-12-23T00:00:06.740810-03:00 linux-ze6w fstrim[32008]: fstrim: /root: FITRIM ioctl failed: Input/output error
> 2019-12-23T00:00:07.523365-03:00 linux-ze6w fstrim[32008]: fstrim: /srv: FITRIM ioctl failed: Input/output error
> 2019-12-23T00:00:08.361831-03:00 linux-ze6w fstrim[32008]: fstrim: /tmp: FITRIM ioctl failed: Input/output error
> 2019-12-23T00:00:09.188937-03:00 linux-ze6w fstrim[32008]: fstrim: /usr/local: FITRIM ioctl failed: Input/output error
> 2019-12-23T00:00:09.974086-03:00 linux-ze6w fstrim[32008]: fstrim: /var: FITRIM ioctl failed: Input/output error
> 2019-12-23T00:00:10.761933-03:00 linux-ze6w fstrim[32008]: fstrim: /: FITRIM ioctl failed: Input/output error

Bet these are all on /dev/sda2 file system.

> 2019-12-23T00:00:10.762050-03:00 linux-ze6w fstrim[32008]: /mnt/so_logic: 27.1 GiB (29089808384 bytes) trimmed on /dev/sdd1
> 2019-12-23T00:00:10.762121-03:00 linux-ze6w fstrim[32008]: /home/chris2: 265.4 GiB (284938117120 bytes) trimmed on /dev/sdc1

I can't tell what file system or device these are on, but it appears
to succeed without error. Therefore the VM is advertising discard
support to the guest. But what is calling fstrim? It appears to not be
fstrim.timer. We still don't know whether it might be the cause of
problems elsewhere in the storage stack that might explain why the
Btrfs file system you care about is being corrupted.



> 2019-12-23T00:00:10.762538-03:00 linux-ze6w systemd[1]: fstrim.service: Failed with result 'exit-code'.
> 2020-01-03T11:30:45.742369-03:00 linux-ze6w fstrim[27910]: fstrim: /boot/grub2/i386-pc: FITRIM ioctl failed: Input/output error

10 days.

"weekly" for systemd timers means "monday at 00:00" local time. Which
is what you're seeing in the first line, but not the second.




-- 
Chris Murphy
