Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5013C12883B
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Dec 2019 09:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbfLUIiF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 21 Dec 2019 03:38:05 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:39909 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfLUIiF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Dec 2019 03:38:05 -0500
Received: by mail-wm1-f49.google.com with SMTP id 20so11328764wmj.4
        for <linux-btrfs@vger.kernel.org>; Sat, 21 Dec 2019 00:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e/Rb/STNucYXTa86EF3GmsP1X8eYpl+TK8Bm6/ysniU=;
        b=KUOfLMTiE1+80AulyjgRtVuO0hDEcITKHLSCZk02kJooJvB+tgZwGXxMeoj3KMJ3t+
         ptDkOMQAGwP8cQ56gcU6wpkpaKN3XAQqXhkDW+/FSyOmO/HH4kU6mFZSlYQVws8Wkw6B
         4Qmp46ahzqNvlJ1b21rB7z2qc/9JHQfqofSt1FvR5rODzPyAz13XMNpOBW5djnD0htuJ
         gR2owvhHtCJ2PBd7JmAjxLjvwmKBjtfhLfuEHULDo8yQbkkNLhCtM9ATlqntDBGvpCXA
         MmdWp5RVM3t2oZfVEICXwFcMg2CPJ73yO8zO/IPWtJFPdBFHYKbXKP8rFBJparStx7/+
         RrXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=e/Rb/STNucYXTa86EF3GmsP1X8eYpl+TK8Bm6/ysniU=;
        b=uZlEXJXylIApLKrnOInuS5JUm4qsc+10oX4BWhJvmuJJltDtJmLtlAh8PREn2tTAuS
         3L61tCZ2HA4Paloe4L9ZkAH5y2wqFprnpySIkyvRNBCTb47pf12hwKPsqlQsAuE4ylVF
         wGWL2LNQMAYLpbNb/K0g1hgEDAqTjzeV13Cb+Lxs3zdzX6rSVJlTtz3u7qoDobjeuycB
         RczUgj2+V2n8tLk4eS1xIYLkSbOz+5gM4XUL29Zz3k/ob5cQAh10RiwiGc2LWAbhDi/B
         ELQcc2S/cyCiRN7BFxJJK98mcjftjt0oaRpG31Eg1FJREtgp4vgJOOBaq4hDYzY39YPl
         YPYQ==
X-Gm-Message-State: APjAAAXX82iB+OQrdjpBQKzdrFWvH4G7ISLOb7t+VSYEZdwykjqCS5Vh
        vnNUvgJVuE7klt8YapAUs5kpZzQ3
X-Google-Smtp-Source: APXvYqw74luKbk+KdhOXGpANFlcV2qoY+X/HS95gh9BdwS7zvz2CIYZsagDSuHX3XU9tT+X3qcB4yg==
X-Received: by 2002:a7b:c936:: with SMTP id h22mr20126958wml.115.1576917483433;
        Sat, 21 Dec 2019 00:38:03 -0800 (PST)
Received: from glet ([91.187.202.82])
        by smtp.gmail.com with ESMTPSA id x11sm12429218wmg.46.2019.12.21.00.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2019 00:38:02 -0800 (PST)
Date:   Sat, 21 Dec 2019 09:38:00 +0100
From:   Andrea Gelmini <andrea.gelmini@gelma.net>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: fstrim is takes a long time on Btrfs and NVMe
Message-ID: <20191221083800.GA85226@glet>
References: <CAJCQCtTQ-xkWtSzXd14hb1bmozg3U8H2pxQMO7PqEJjymCcCGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJCQCtTQ-xkWtSzXd14hb1bmozg3U8H2pxQMO7PqEJjymCcCGA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 20, 2019 at 11:24:24PM -0700, Chris Murphy wrote:
> Hi,
> 
> Recent kernels, I think since 5.1 or 5.2, but tested today on 5.3.18,
> 5.4.5, 5.5.0rc2, takes quite a long time for `fstrim /` to complete,
> just over 1 minute.

Same effect here, since more than one year (and all update kernel
version).

It happens with my laptop devices:
nvme: KBG30ZMT128G TOSHIBA                     1         128,04  GB / 128,04  GB    512   B +  0 B   (Firm. 0108ADLA)
SSD sata: Samsung SSD 860 EVO 4TB (Firmw. RVT02B6Q)

I guess it doesn't matter, anyway:
nvme: btrfs
ssd: ext4 on cryptsetup + lvm

Ciao,
Gelma
