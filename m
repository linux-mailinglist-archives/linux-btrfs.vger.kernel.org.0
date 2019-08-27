Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56A6D9F5D5
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2019 00:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbfH0WKy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 18:10:54 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33169 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfH0WKy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 18:10:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id u16so385813wrr.0
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2019 15:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qc839KheCGl7U3e1YOMWcC4Kru0c5b/pxJkcQ1H2imc=;
        b=2NB4s6376VnIOAEzznn2634qHDpJK1WA2Lw3QxFWM8+MlfbecTTh/KJJFSycEwZUnu
         dPDSoHpeprcpRhUmzAL+VJ112LjCix1ENd/AUAt1MyBMWEFV50BQIWWAvTgrPmjakQ9a
         VzVP8LOtazCOfioE7q7VRfdj4nJEmh4Ww4rtGtQoY22wz8462E7H73K4Am+lu38zzAV5
         5D/f9ZmXEtBHA4HyRZ6zVpyPrMsyvvxzHgdP6umk0IdN0uFMA9i2rzFDoauLMJKJec5h
         eyNl/1tGL4Ab7LZnlY3a3a0Rtvo2S6HTScFhT3LHnhPuCEOYefjqIKLLK2rNmsFFki/R
         bgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qc839KheCGl7U3e1YOMWcC4Kru0c5b/pxJkcQ1H2imc=;
        b=fzZbwCUJHq+/9usbCoQlNYq1VufFKBbzYmTAwBVDpDb5eeCcn357ug5HbMZ7B3spY/
         /llsUhAQMOeOB453RvmyBnqqLiNIWbwiOaLu8H0MCkSVzemtdqfQrsRhMVPvMbjvt2Pd
         Hvei5QYb96S9q5dYVJU00DXBYbDhJ6lHSJjhJGiU2h85eaw+1dc+1cyQ8s/9k9Qeh2/m
         a+mtOyfVC5y9YU2h4v04WJm0xI/PrurfCkWi3QWP8G3fJlvgW9S6vsahskGFMROkOQO4
         owVq/DkiplyXhrseBdLL1HdfhcT/CZyZNtE5HwP30cnBBOEQtDGUWmGpNDD0wYOtv/ZP
         fbUg==
X-Gm-Message-State: APjAAAUJK6SzArqPmO0X+WM8QvPy0KG6QqWtLPhQDSZWb5cgO2deVSam
        GeETR9e/aZzjkBzuP0cJPmsAw51lDXM/+yj6bVCJ8g==
X-Google-Smtp-Source: APXvYqyyAa5vnMe/QttptuZTALXT/DRa6D73t5NncxuwL0QjP4ci3TDY+fuDFAfbfOvJHKlTofYDdKUqRPdD3mHW8sQ=
X-Received: by 2002:a5d:494d:: with SMTP id r13mr374009wrs.82.1566943852762;
 Tue, 27 Aug 2019 15:10:52 -0700 (PDT)
MIME-Version: 1.0
References: <11e4e889f903ddad682297c4420faeb0245414cf.camel@scientia.net>
 <18d24f2f-4d33-10aa-5052-c358d4f7c328@petaramesh.org> <a8968a812e270a0dd80c4cf431a8437d3a7daba5.camel@scientia.net>
 <5aefca34-224a-0a81-c930-4ccfcd144aef@petaramesh.org> <4bd70aa2-7ad0-d5c6-bc1f-22340afaac60@petaramesh.org>
 <370697f1-24c9-c8bd-01a7-c2885a7ece05@gmx.com> <fcd2e070-67e9-4889-f778-748070cc9856@petaramesh.org>
 <DB7P191MB0377516063743C8D5A382C4292A00@DB7P191MB0377.EURP191.PROD.OUTLOOK.COM>
In-Reply-To: <DB7P191MB0377516063743C8D5A382C4292A00@DB7P191MB0377.EURP191.PROD.OUTLOOK.COM>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 27 Aug 2019 16:10:41 -0600
Message-ID: <CAJCQCtTmSOz9sOqoXiHDCctoQYKzTpkpSubdaJC9hXyDk16Tbw@mail.gmail.com>
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
To:     Alberto Bursi <alberto.bursi@outlook.it>
Cc:     =?UTF-8?Q?Sw=C3=A2mi_Petaramesh?= <swami@petaramesh.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Christoph Anton Mitterer <calestyo@scientia.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 27, 2019 at 5:11 AM Alberto Bursi <alberto.bursi@outlook.it> wrote:

> If you want to fully clear cache you need to use (on an unmounted
> filesystem)
>
> btrfs check --clear-space-cache v1 /dev/sdX
>
> or
>
> btrfs check  --clear-space-cache v2 /dev/sdX

I recommend a minimum version of btrfs-progs 5.1 for either of these
commands. Before that version, a crash mid write of updating the
extent tree can cause file system corruption. In my case, all data
could be extracted merely by mounting -o ro, but I did have to
recreated that file system from scratch.



--
Chris Murphy
