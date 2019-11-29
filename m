Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 582FF10DAD7
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Nov 2019 22:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfK2VRs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Nov 2019 16:17:48 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:32936 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbfK2VRs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Nov 2019 16:17:48 -0500
Received: by mail-wr1-f52.google.com with SMTP id b6so7078505wrq.0
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Nov 2019 13:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y3rDNiS1F2B9yUDhkVLhXf2PaeYfKnr56ykOXLajLqU=;
        b=rBYhJbqhQ/FP/+FPH0lnBZJ7Q470XEzudyns8gPS+5mlpFeNGFk5wyjXXbqO0K4jJ4
         0gIa+hKVnr7VH1edX9K8PuvIqaAcz1EH8MwE0GiLPSHBzB5rhMoyojcblu/HSvYz8cZO
         Ib+tHiy2qsIHrdNScihPN0/xVYdQC75LtELEcM07ulMiYTCRr8K272eN229nCIcFJqfT
         tdCe5Y10nvVK6a2RSEkUU9nOVJ8WqFosM1SJHd7BYvkJHIbcCvbEi9rhBNk1+MrPoaYD
         29JrYIoP8cvpOzjOURwunapWPdE6iuRlttdUBWmwE8xcD/Yu/GCfOChhEMAxp1ljIj6r
         +9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y3rDNiS1F2B9yUDhkVLhXf2PaeYfKnr56ykOXLajLqU=;
        b=Wc0wTDHKYb1whInHu25IigcrXSkFguj0dfDogCUyWwx1r6m1HqOGZtMp+9HJhrUzAO
         uCy7Ep1P9O70lZYKrQ3VzswOu9Ic5u8bL2y7m6iTLa0JxH//QjJcDdz7PY4Rq3uuD6A/
         i//PGZvuMA5tniv8d4l0cSIVRGLTUE+MQ3AQyglqu0VUUDsvIlC1pivqOT6zfSjlOU5K
         S3iKIlO8fCz+Oy/73+sJz5BCXPY1c9BXNfMLh3vLrn6Fiz7GAjoEE22qdcY5bolr+ZFG
         un7MXiT4krW6YMFTfqZvNEnmL6t0NI192wEfXT7ZLFauYt4tDb6OeuNbXXYUk9EjQ8eY
         2sZg==
X-Gm-Message-State: APjAAAU3QJstitAPFdHIVcVQ8uEcBuvXcz1P17B/kmzxwRu+ZXX4ox/4
        iAEORe/Ad7rhgeGv6Vo3RvqorbYwlDIznV/+qSHx0Q==
X-Google-Smtp-Source: APXvYqx4O4Xe1PiNsDF3ydahzWH6tubW6qE01vehBwzaLnArrwE8lidYWsIvC7VZPVXXL3NIn2qyv2bMi/axe0niti8=
X-Received: by 2002:adf:ea4e:: with SMTP id j14mr7691362wrn.101.1575062265929;
 Fri, 29 Nov 2019 13:17:45 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtSeZu8fRzjABXh3wxvBDEajGutAU4LWu0RcJv-6pd+RGQ@mail.gmail.com>
 <a48a6c50-3a03-0420-ad8c-f589fafe6035@libero.it> <CAJCQCtR6zMNKnhL7OZ8ZGCDwPfjC9a1cBOg+wt2VqoJTA_NbCQ@mail.gmail.com>
 <CAJCQCtS2CP75JTT4a6y=rzqVtkMTqTRoCvJK9z3mMwLRfKo9Xw@mail.gmail.com>
 <12f98aaa-14f0-a059-379a-1d1a53375f97@inwind.it> <CAJCQCtQF6xtBDWc+i3FezWZUqGsj8hJrAzYpWG+=huFkmOK==g@mail.gmail.com>
 <69aaf772-9eb0-945a-5277-40895e6901de@inwind.it> <CAJCQCtS6V+f5hq2Cu4r7g9nXB-nRPwUaL+=rh_Ets2mWtHrMcA@mail.gmail.com>
 <35b330e9-6ed7-8a34-7e96-601c19ec635c@inwind.it> <CAJCQCtQaq7r2G7Ff--n5g2eVknPtKcQjebj-=eoNjM-18hwhKw@mail.gmail.com>
 <0ce1c050-d90c-1351-ff56-4edc054463a4@inwind.it>
In-Reply-To: <0ce1c050-d90c-1351-ff56-4edc054463a4@inwind.it>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 29 Nov 2019 14:17:30 -0700
Message-ID: <CAJCQCtQSgTG=r0+i=M7nKgz5ncqcfEkZmQci5Kk12PmDVzgmbg@mail.gmail.com>
Subject: Re: GRUB bug with Btrfs multiple devices
To:     Goffredo Baroncelli <kreijack@inwind.it>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 29, 2019 at 12:54 PM Goffredo Baroncelli <kreijack@inwind.it> wrote:
> Could you be so kindly to share the picture of the loading of the kernel/initramdisk ? Something like:
>
> grub> set debug=all
> grub> initrd /boot/initrd....
>
> I hope that the errors come quickly. I don't think that we need the pictuers of all the download. It would be sufficient the pictures until the first (or better second) error....

I paged through it for minutes, hundreds of pages and never found any
errors. But these are the first pages. This might actually be some
kind of search, not load of the kernel, because I pressed tab to
autocomplete. But it didn't autocomplete it immediately started
spitting out debug pages.

https://photos.app.goo.gl/kpa7dJ9spAy29yj26

Is it possible to redirect grub debug output to a FAT file?



-- 
Chris Murphy
