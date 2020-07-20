Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88062226F13
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jul 2020 21:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgGTTdR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jul 2020 15:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgGTTdQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jul 2020 15:33:16 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E44C061794
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jul 2020 12:33:16 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a14so4109266wra.5
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jul 2020 12:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=R+By1IFBfRSOYyDfHniY0rKEhzamxhWDcpwHJXUVS3I=;
        b=pxN7ISlA6nIMRRryB1tkCj295CiHm6Ls0isHpnEiiYxmJx7l2IMF5D1diGLPDgRJPV
         2njNpMLgF9oyw0iVZCvmIV81VXCFXo0vfXDrRvWiZViN6msZ3StWaA1fiWPwAAq4EHfd
         T+ojwxKfkAravW/Q7T+4+aJt3fENbYHkw/vF/t2X7mZKlSSbIlVF0ducYCNWlCTW5Z8P
         Nl6oG1PApqGxVvnKNpNFfjILJLweKKlXKtqvhDYd6QMwB1ke45T2x5wgOtODaos1WH1/
         P2VZ7uqEZ4zGEBccsOdMLwur5ApxJQ5OdHzQODrri/jcVEV5ggl0pWtQ2yl765PpMcIs
         fGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R+By1IFBfRSOYyDfHniY0rKEhzamxhWDcpwHJXUVS3I=;
        b=G7ldCWYiEImhDg11DSSPyrPTZrRoGKCV+gPlmI7GAwrHBl/QRNL4OkAluOlQ8MKUrC
         gdy4nOkxPuJ/6/dZdfeqeLRw7+lY2xIQnHN6G1BxuYZHQKSvB5aqOtF1A50CbELCe9Mk
         G6MDl8DuffIGAjB+vdCV9MDRtDXjjIxR0SfwOUqiNnMjKNqbRBq8BB59h4OGUDH0pH5t
         vX/jkfrooD1u0T/jpN3q5WyFw67PcLsXkwCf+hEXmkOB30dlEO+tAHESPtlZVh8mkMA2
         Vdq0nRc4cGQpuZfbbiPrg1m9cbVPQ7WHBRvFBN3vJSDqnKOxiDnO7AG42ukh27JjYUVG
         AgJA==
X-Gm-Message-State: AOAM533V6u0qoeZIOB1dT3Kyk4nQId5vaCXSaQBSt6m9K18CB9Vx+i1X
        Mm+9QX+8TJeIKzefBgo0nwP4LliO
X-Google-Smtp-Source: ABdhPJxp7N/aDAsaGM18tr4M9sb2mqFQb4ujlOTPE9rLjEBbe9T0LcXghtlcUSBWXFvEjHxNHjDAow==
X-Received: by 2002:adf:fd04:: with SMTP id e4mr6854820wrr.353.1595273595150;
        Mon, 20 Jul 2020 12:33:15 -0700 (PDT)
Received: from [10.0.0.9] (193-81-178-226.adsl.highway.telekom.at. [193.81.178.226])
        by smtp.googlemail.com with ESMTPSA id 1sm605511wmf.21.2020.07.20.12.33.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 12:33:14 -0700 (PDT)
Subject: Re: "missing data block" when converting ext4 to btrfs
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <90fff9c0-36c5-d45c-d19b-01294fc93b1e@gmail.com>
 <763ee221-92fa-a84c-db8e-9d05e88bab0c@gmx.com>
 <09c51964-9762-a7a7-02c3-ac398790ff0d@gmail.com>
 <b49c8f68-5897-7bc1-21d5-03125e798a76@gmx.com>
 <409fb0aa-7c7f-db52-6442-d746b9944fa3@gmail.com>
 <46ea54ea-3ed3-f1b7-7314-a69f4195c8f9@gmx.com>
 <8678a4f9-3388-5a7b-00cc-8b9da6a0a6e8@gmail.com>
 <acbe2fee-1462-7631-22cc-19af58da8b57@gmx.com>
From:   Christian Zangl <coralllama@gmail.com>
Message-ID: <37863fea-7b36-7bbe-98ce-7e4e9c0d6a0a@gmail.com>
Date:   Mon, 20 Jul 2020 21:33:13 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <acbe2fee-1462-7631-22cc-19af58da8b57@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Great! Thanks for finding and fixing the bug!

Christian

On 2020-07-20 14:56, Qu Wenruo wrote:
> Hi Christian,
> 
> Thanks for your detailed report.
> 
> Now we have pinned down the bug, it's a bit overflow for multiplying
> unsigned int.
> 
> At least not some fundamental design defeat of btrfs-convert.
> 
> The fix has been Cced to you, and passed my local test.
> Test case has also been submitted.
> 
> Thanks again for your help!
> Qu
> 

