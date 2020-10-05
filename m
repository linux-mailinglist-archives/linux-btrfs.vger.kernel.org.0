Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4912528366F
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Oct 2020 15:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgJENWv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Oct 2020 09:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgJENWv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Oct 2020 09:22:51 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3ABC0613CE
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Oct 2020 06:22:51 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id j22so9476671qtj.8
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Oct 2020 06:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VIgwe0JHMpCsWtyL0UC/jfREZOke1ZFWSMztrR3WjOk=;
        b=ZBBGKX62oyUHCZWldidySppRJ/gMVqVAy7Rn/kategGhPk2fuLGsL3QNUEcgP424RA
         HEcTF8KV6aojMtfWTZjoTmPsCj30WaHMZOlaAgdbLUXCv9hBGUvsiH7pS3U82bEp6UXK
         M1caCvKJMIYlguYpILxY+f4Y0p90U2ottBS5SABX8rfApEsv0cRVdKryOIr1LygCLGSH
         b8KEoKJCB9gnxUga1q0SFHF4kpexC9VkZ28Lryt0518O2xpPRJNmPLdAClg5ywufRjQI
         xfFJkdl8ny8qhUPN+3fU7p4uuvyFMuD5p7ZS1d9i6eVl0YMAnMMk5C1u8f5tpOhHtzLT
         a+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VIgwe0JHMpCsWtyL0UC/jfREZOke1ZFWSMztrR3WjOk=;
        b=B9TSZU7zStSvQ/TXb4gUfVqbN63FbVarIfXIZKY5gex0Ut/2FR4vayWSY93MOH1Aod
         ZlHdo5APUku94JZ4Afm2cDq9Y0krI/znyLwQY/CEIjClEOaIfFUhSmWv8MCmMnGYnISb
         GFALbA7NUigNBbsInixfx0+qMGl51SDUFA+wdAx7W3F2kyt4rLwZ+HYZQyBMiVLDe9ly
         Yruu8UETIzmrjk/nP79JXvxT/mRzx+A96z0nhivjjARIQnMQtrOfyIJeYUCP9VXZnZle
         fDrJvsBMiRckg2MQIqXVK8oaPPczDSkRhML1dOFMJm+xoSyQs7ki4g7/BnH9T25+X2k/
         hs6A==
X-Gm-Message-State: AOAM530vVUzVW9tuRkDwYsB6OdRNfgt0izA16hqGrfTMf3D5hwLyN9Yl
        A7OEA70cGNaYM0riKkV1XMOghOZT1oVcJEAc
X-Google-Smtp-Source: ABdhPJy4vWmMB5n5fAiJdzoNyNt10S4imgm4MzQMmJjzL1HtJVrHW8124/G/fceuCiQOesaRGJs3LA==
X-Received: by 2002:ac8:6916:: with SMTP id e22mr14160336qtr.141.1601904170650;
        Mon, 05 Oct 2020 06:22:50 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d37sm2499156qta.76.2020.10.05.06.22.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2020 06:22:49 -0700 (PDT)
Subject: Re: [PATCH 1/2] btrfs: drop never met condition of disk_total_bytes
 == 0
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     nborisov@suse.com, wqu@suse.com, dsterba@suse.com
References: <cover.1600940809.git.anand.jain@oracle.com>
 <4fea8a706aedf7407d6af7a545126511168e15f5.1600940809.git.anand.jain@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <2a768517-2ab4-8671-5d70-e80ed01e406d@toxicpanda.com>
Date:   Mon, 5 Oct 2020 09:22:48 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <4fea8a706aedf7407d6af7a545126511168e15f5.1600940809.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/24/20 6:11 AM, Anand Jain wrote:
> btrfs_device::disk_total_bytes is set even for a seed device (the
> comment is wrong).
> 
> The function fill_device_from_item() does the job of reading it from the
> item and updating btrfs_device::disk_total_bytes. So both the missing
> device and the seed devices do have their disk_total_bytes updated.
> 
> So this patch removes the check dev->disk_total_bytes == 0 in the
> function verify_one_dev_extent()
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Ok I understand that logically this check is incorrect, however we pull this 
value from the device item, which could be corrupt.  I'm looking around and I 
don't see a similar check in any of our other code, it should probably go in 
check_dev_item() maybe?  I think that removing this check is ok, but we need to 
make sure we catch the invalid case where total_disk_bytes == 0 somewhere, so 
please add that in the appropriate place.  Thanks,

Josef
