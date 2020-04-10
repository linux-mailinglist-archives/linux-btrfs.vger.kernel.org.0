Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A60D1A47F2
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Apr 2020 17:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgDJPor (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Apr 2020 11:44:47 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46253 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgDJPor (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Apr 2020 11:44:47 -0400
Received: by mail-qt1-f196.google.com with SMTP id g7so1706523qtj.13
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Apr 2020 08:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=xKOSllbK18XYZIYtPPRrM4cvMNprpulIr/S6iIeQkFE=;
        b=Mk0XIaA7HrSNO4JTEAYzS0CtiqD5lR1m3q8rffdmGbVvYDaLQ6jsqQgeqwhE7Xa/lO
         Ru6AOdw9vjyGG8YAdrOzreT2b6PW3LGB1BPJaibtimKloLmmSEo4QDkwDJGgbdUlnVw7
         Kh76XqIQASb0PJGsB8v3on8wtsjKcTVOd5A5+pHqqWKC1sFrak7P+7tKOnBMjnZtPDPt
         SXOIXXooWrA52D9iumIblBsMe/ZdHmVuUi3JEN9lF7O1dHzeLhBeugC30+Ix+2KIuw4I
         1vct47v1OoWbLAGGYnIlgEdkDDqq/Pidxpe599+QN5QCzx9Eeq2xdy9MWdipU/84RrPv
         C1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xKOSllbK18XYZIYtPPRrM4cvMNprpulIr/S6iIeQkFE=;
        b=bXSBLDgMbdch5bGXuU8yarnkPYoomHm2udJbAXCL508dFPF1t6evC1gmdVGihUxJ7y
         X7GrlTZy3QjcmolRNzKLmPZ6MN3ZGw5gggkxw8X2xFZvstqltlTbYGc8l2rf5ex5bChQ
         n2ImWMQnX4w9SOv0F5Kx1Pdb3e/kDR1e2bmiEirrDyZ9QoWZq3h3cWZdKWyDKLECDSkz
         sq997InpZdMf34dsIlt789lA37sPJ2NQD2F+F2G7F16HvCdN0dvOPsVOGzqyI0uXdvgo
         0Onel12GLqpcqW0dz6bhV7nkcBiuLr9gnXbrbB11JjOY6MtO3pDq7Ax9LikZr2hPuose
         ey/g==
X-Gm-Message-State: AGi0PubQujEcltdlBcM/zYBc9swRzWrOxNeToS5b1Wwc9x0qlGAq6jG4
        Li4wL3lCb2dH1za5Oc87DhNFCA==
X-Google-Smtp-Source: APiQypK45AYotUA4Ul1Cqd8njxn1J+XbCT14fKHs5UMOyMDmFOL6JZlAJTPrRanShUFI1bM2pNMm1A==
X-Received: by 2002:ac8:82f:: with SMTP id u44mr4905822qth.198.1586533485404;
        Fri, 10 Apr 2020 08:44:45 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id o5sm1798777qkh.77.2020.04.10.08.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2020 08:44:44 -0700 (PDT)
Subject: Re: [PATCH] btrfs: fix improper generation setting in parent node
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200406145905.112078-1-josef@toxicpanda.com>
Message-ID: <38f17c0c-1c63-b654-c2c2-88dc37c87cf6@toxicpanda.com>
Date:   Fri, 10 Apr 2020 11:44:43 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200406145905.112078-1-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/6/20 10:59 AM, Josef Bacik wrote:
> With the delayed ref throttling patches I started getting a lot of
> "parent transid mismatch" messages when running my snapshot+balance
> torture test.  This turned out to be because we will unconditionally set
> the generation of a relocated tree block to the current transaction.
> 
> This is generally true, but especially for mid-tree nodes we could have
> cow'ed the block in a previous transaction, and only actually update
> it's parents in a completely different transaction.  Thus we end up with
> a parent transid that is in the future of the actual block.  Fix this by
> using the generation for the extent buffer we're pointing to.
> 
> Fixes: 5d4f98a28c7d ("Btrfs: Mixed back reference  (FORWARD ROLLING FORMAT CHANGE)")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Dave hold off on this, there's something odd happening that I need to figure 
out.  Thanks,

Josef
