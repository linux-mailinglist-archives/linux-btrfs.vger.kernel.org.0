Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B20C019B727
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Apr 2020 22:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732735AbgDAUkQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Apr 2020 16:40:16 -0400
Received: from mail-qt1-f171.google.com ([209.85.160.171]:43383 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732350AbgDAUkP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Apr 2020 16:40:15 -0400
Received: by mail-qt1-f171.google.com with SMTP id a5so1356334qtw.10
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Apr 2020 13:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=H14W9xiP7ER9jsEi3D3RO4QojoUJN0h08bYSv/2dyrg=;
        b=gJBZuzMD1ThZE27OIYxzE6x08FPbJXrPag8R5PIo5LOHuzHq62m8v31y12IpXK2v2f
         G0qochZ2PtCI8QP9VDef37po/VO/NN4BCQD4r5trJEjXT/kGJtJrNbkNEy3u27RiJXh8
         O8QighOTtdX3WjKx8es+EuA9+VQUcehyTu1gyfZ6AzHOnf3pyyISHaUBpHJiGPH6Ququ
         2Z0wVD3mTZb6ZfZJo+tlB1Qsz/qRhGZq0vtBtig7QFPN1k+0YjMiwJC+UXqtjzNnRgud
         X6zTFOaKQNTVDZZoZ4OHT/LvM+qVqeDrmS1wketcr5GrJUB/g9KsYxiskYbNwyBYY/87
         H7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H14W9xiP7ER9jsEi3D3RO4QojoUJN0h08bYSv/2dyrg=;
        b=gN9s3UOzjlANfguK/IlwRAZSL76oQ2/bpiotU+3M0JgoEoRowIqQhQNQHA7H0J1T2q
         VQ7DsjFT80BdiJjp/vgA7t5jRecuqBhMO5WYYESXAun3QZgnNmho7PDNWKv+BSZR9R9T
         /2/k472pdoOscCtuduuKa9RhyA5pB458VpGAQDuRngrhUXeZTBos8H+T0wmJHGSW1HM4
         6ZG10gPZyAtcxy6Y140vLQ1q6J1nv8+ltBrJxmaTBdsDPxfwaUk/QRSBlak2ckqI8uxf
         jLmItIeI++y4BCNlrxGlhUXPo0fVzisisG+BJASvbzgLSBoij2ChCv7eciGh8ZuimY66
         /dLg==
X-Gm-Message-State: ANhLgQ3TnSiGr9xJQgfDbUXBUzKd/lqgtMvqNbbeUql46GKo/Gpsq+Go
        tI7VMrNHoE0Qk1UzXB64VHPyuzpq0qiq0w==
X-Google-Smtp-Source: ADFU+vsmdZxLqb6FyjGZv2QOcjgCeZBvGgTHeNjMWsBzUZKM4iwcccQRHTQ3K0voUbt2PzZBsCwRfQ==
X-Received: by 2002:aed:2c06:: with SMTP id f6mr12290169qtd.337.1585773612711;
        Wed, 01 Apr 2020 13:40:12 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 27sm196267qkv.7.2020.04.01.13.40.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 13:40:12 -0700 (PDT)
Subject: Re: Btrfs transid corruption
To:     Christoph Anton Mitterer <calestyo@scientia.net>,
        linux-btrfs@vger.kernel.org
References: <800B6BF0-64AA-45F5-A539-9D2868C2835C@scientia.net>
 <a8a1e614-d5f0-d4b6-2f0b-626a34761758@toxicpanda.com>
 <2FA13CAC-C259-41BF-BA9E-F9032DFA185C@scientia.net>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <c0e5cc1b-ddfa-270e-2934-a6470584193e@toxicpanda.com>
Date:   Wed, 1 Apr 2020 16:40:11 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <2FA13CAC-C259-41BF-BA9E-F9032DFA185C@scientia.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/1/20 4:37 PM, Christoph Anton Mitterer wrote:
> Am 1. April 2020 22:31:58 MESZ schrieb Josef Bacik <josef@toxicpanda.com>:
>> On 4/1/20 4:06 PM, Christoph Anton Mitterer wrote:
>> Looks like the tree log got corrupted, you can use mount -o nologreplay
>> to get
>> it mounted, and then you should be good to go (hopefully).  Thanks,
> 
> 
> I can mount it then, but only with ro...without ro I got another ctree open error (see Google drive for screenshot).
> 
> But this is then only to rescue the data...I cannot repair the fs, right?
> 

Oops sorry, boot into rescue mode and while the fs is unmounted do

btrfs rescue zero-log /dev/whatever

and then you'll be fine.  Thanks,

Josef
