Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C752130514
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jan 2020 00:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgADXuD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 4 Jan 2020 18:50:03 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40696 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbgADXuD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 4 Jan 2020 18:50:03 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so45799637wrn.7
        for <linux-btrfs@vger.kernel.org>; Sat, 04 Jan 2020 15:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A2Y+GeauVygmDU4TS1CeTNciGcs/phupjLL/HsqRVtQ=;
        b=lX/O8LPOGeYqI0axiMpskiyAouBBJEF+JpSUvdCJQEuvrqUf4U98VzVGZiNDR02nVd
         RFDFH0eiHLSc9uVF1aLz7QS6PlXIoSDxJHX/eaAZS0PPl5MjOtKbzbQH/bpodlyfmi3t
         MMgDCZe6JYKJShrRcbV36B083dQpFvrd87jHXIud3JpSxA4Ezi9RC97vCWvqMyO32Ojy
         stOA5+3po1olUDE4ebbfefv64KG3AWGpMtLwnRpei3WWLayLTwxobCLqYDgor8wYvtzT
         j7K6OmpLM3pHrN8DHcCtHVqjla5sVYbumeX13SEZmrASxv4FTYnG1qRP4AiXy2/6tKBQ
         yTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A2Y+GeauVygmDU4TS1CeTNciGcs/phupjLL/HsqRVtQ=;
        b=MoNqFcxTzgLvgTnbr4nyRNLMr0AohcTab09Q8bVQ+crpzBo9mc3X3P+ODvoCkVU0jC
         ot5t4rw01RG90WaIp4MaPD32qPzk/gVgE8Ghf5mvSBqLldtSixdtwx9p8pa9aRfZaJLR
         lFMLnGfrkdkBUYnh/eCKHEXBAFCEzovihT0CwfolIQzQrJbDPQ5X8cNuRZ1QGBMaFsvI
         Nl4O9JvokvRD+uGdS535eCbRE9X3B5vMQXdmStYq3NO0S09KKgFhLF5YGW+b0C/wdMwb
         I5w3uKRaKzjKZW3EEPxSNxtYif0ZjfPoLk1r3BWSZRV+qsnQrCPaibn/rS+LmmAYoJkf
         R8Xg==
X-Gm-Message-State: APjAAAUBYy5fN4hbgiUpVWhD1dOse1t2rooK3+5kEpZsp8viODU3kgDh
        TXMvv84l6hcaFsf2NvUrRGyJbigawRJY803IVB2/65gf738=
X-Google-Smtp-Source: APXvYqyckZmVoZG4pOWhwiqt3PQJ6LNXG4RYA2TaHQA6ETldEnPQQkZoZsKifIRfrZuNjmn7sUUZVfyrRIkj/Ct4NV0=
X-Received: by 2002:adf:9c8f:: with SMTP id d15mr96234661wre.390.1578181800469;
 Sat, 04 Jan 2020 15:50:00 -0800 (PST)
MIME-Version: 1.0
References: <d081f5fc-7132-6b18-f740-738993fd18e7@grossmann-technologies.de>
In-Reply-To: <d081f5fc-7132-6b18-f740-738993fd18e7@grossmann-technologies.de>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 4 Jan 2020 16:49:44 -0700
Message-ID: <CAJCQCtSqs-zmb7q6bXmGd+_Las+btBSiL35Nigo6tBfAiD2FwQ@mail.gmail.com>
Subject: Re: timed out waiting for device dev-disk-by\x2duuid after disk
 failure on btrfs raid1
To:     =?UTF-8?Q?Georg_Gro=C3=9Fmann?= <georg@grossmann-technologies.de>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 4, 2020 at 3:46 PM Georg Gro=C3=9Fmann
<georg@grossmann-technologies.de> wrote:
>
> Dear btrfs community,
>
> I wanted to use a setup with Open Suse Tumbleweed together with with a
> btrfs raid 1 on two disks in my virtual box. I want a system that can
> still boot if one of the disks fails so I installed a bootloader to each
> of the disks in /dev/sda1 and /dev/sdb1.
>
> I then used /dev/sda2 and /dev/sdb2 for the btrfs raid 1. After
> unplugging one disk, the boot process always fails with the message
> "timed out waiting for device dev-disk-by\x2duuid". I found a mailing
> list here
> https://lists.freedesktop.org/archives/systemd-devel/2014-May/019217.html
> which pretty well describes my problem. Unfortunately, I can't find an
> appropriate solution there. Since this mailing list is from 2014, has
> there been some progress in the meantime? Or is this the expected
> behaviour and the user has to help himself out manually?

It's the same situation.

Most distributions have a udev rule that waits indefinitely for all
Btrfs member devices to appear. This is done because Btrfs doesn't
have automatic degraded mount. If mount is attempted, and any device
is missing, mount fails - even if there is a tiny delay (somewhat
common) rather than a device failure that causes a device to be
missing. So instead, udev waits. Mount isn't even attempted.

Should the udev rule wait for 1-2 minutes, similar to the dracut
script for mdadm arrays? Even if it did, it just means we get to mount
after the wait, and now mount fails because Btrfs doesn't have
automatic degraded mount. What's the trouble with deleting this udev
rule, and then always using degraded mount option in fstab or as a
kernel rootflags parameter? If there is any small delay with any
device becoming available at mount time, you get a degraded mount. And
however briefly, the drives can be out of sync. There is no automatic
resync once all devices do become available, and Btrfs has no concept
of becoming "undegraded". All of this makes things messy for the
casual user, so the decision so far is to just wait indefinitely,
using this udev rule.

And the open question is what should this look like in 5 or 10 years?
The btrfs on-disk format has enough information to figure out how to
do a partial resync to catch up a slow device, similar to the mdadm
write intent bitmap + resync. But does this need some enhancement so
it can be totally unattended? Like a partial scrub capability?

There are more questions than answers so far, that's why it requires
intervention.


--=20
Chris Murphy
