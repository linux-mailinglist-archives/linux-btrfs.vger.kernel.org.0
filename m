Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C03651A4A59
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Apr 2020 21:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgDJTXy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Apr 2020 15:23:54 -0400
Received: from mail-qt1-f171.google.com ([209.85.160.171]:43697 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgDJTXy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Apr 2020 15:23:54 -0400
Received: by mail-qt1-f171.google.com with SMTP id z90so2258923qtd.10
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Apr 2020 12:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=/XBfGOkdPAfwexI7JKzTUrRLNzepi2AGh4BfCh+nskw=;
        b=IqE07dykKyrPIRWT6Tkv8HXJ1HcCDvng5S4TYv9AEaVY5aK1ZXMWYq7nXwtFeyqIMu
         ens4OHRy1Qp+kaLDrp4Hmvi6tHPs11JaaTY3Lx4OSbhx9drGFLvK43fT+8rCNCv4p8Pu
         QCrtAxIH5aad7JtHXUnzyvj2LG7G2bWgVXKnVc+mdTW5iQ0BYF3+Ky4KwQQbfWanfQhR
         CI51r6p+bKyy48HbvmP6elTmg0hcIgUl6Q87xlL+47TBSeuoGnBKEtxI+pAOyVhPSeVU
         IRPRzuVUYN4vm7WNeED4TE9uyWrVCfZFs4FQRZVeE1KkPZcJVNaI5ioCml6t5lbVkggk
         uUUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/XBfGOkdPAfwexI7JKzTUrRLNzepi2AGh4BfCh+nskw=;
        b=A3z76U6JdWpjLsrUp8KAk96u3ID7qDtyP8xASjheVF9rHNSQwTDeXSUmOeBKUuGDfw
         IOO4dQgFFgW7TXZNB/WGGxw7yDf5DN2nVK8hvESYjr/bd93vc3weRaLU5T962I7znDbL
         NAh6DghqQJCd0MoPcPlv4NlmRT9cA8RhExoV2O3b9DLRg+iKZJVP/mFXcHSce2dAm90O
         Y/hGalOqf9YtKs9HHyJ1tcFDMFeOiNxLfpclZPYpAdT9hMyoGfTFEjZC9dbsVtxNWe33
         H8JwDSltScKSoVNuUwyeUBzaEq7zjZ1jhIrm1DRPJFRsh9Wq0aWYDznKpBO/HVAYV2Jz
         AIHQ==
X-Gm-Message-State: AGi0PuZp7AhOVRaEgG6yj7VSiZ6+g6jQoKdrC0bCjGVZFIRpWVqb17cp
        6eLnYLEKYy7FW0VCxdgJhyy2ZB6Dy/7PXg==
X-Google-Smtp-Source: APiQypKeU2Lpy4eOsdUD1o8WtLm3tmHqCiCrKq5oyQSOrslqMuZhJS+afzk+p6i+r3+o9MQUX22A+w==
X-Received: by 2002:ac8:1343:: with SMTP id f3mr672559qtj.389.1586546633234;
        Fri, 10 Apr 2020 12:23:53 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id e26sm2230043qto.90.2020.04.10.12.23.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2020 12:23:52 -0700 (PDT)
Subject: Re: [RESEND PATCH] btrfs: Remove received information from snapshot
 on ro->rw switch
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200403134436.9095-1-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <b5e5c36a-4480-5faf-964d-4a44a85a791f@toxicpanda.com>
Date:   Fri, 10 Apr 2020 15:23:51 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200403134436.9095-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/3/20 9:44 AM, Nikolay Borisov wrote:
> Currently when a read-only snapshot is received and subsequently its
> ro property is set to false i.e. switched to rw-mode the
> received_uuid/stime/rtime/stransid/rtransid of that subvol remains
> intact. However, once the received volume is switched to RW mode we
> cannot guaranteee that it contains the same data, so it makes sense
> to remove those fields which indicate this volume was ever
> send/received. Additionally, sending such volume can cause conflicts
> due to the presence of received_uuid.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> Suggested-by: David Sterba <dsterba@suse.cz>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
