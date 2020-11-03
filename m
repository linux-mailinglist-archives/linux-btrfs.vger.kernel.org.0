Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6EDB2A4A78
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 16:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgKCP6C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 10:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgKCP6C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Nov 2020 10:58:02 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E15C0613D1
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Nov 2020 07:58:01 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id q1so5849726qvn.5
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Nov 2020 07:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2DFUWZMjdYCRr74/VE0fH9TXzYLb8WHFi/lJO7XkynM=;
        b=p+QS+SZcMezcXlGT7PQs4JqHZHD3ZQSkpsRcX+rRPAIDoTx/13pYLsy4664kWtr0Nh
         CWgjb39mZw+fBrlHyJZiIwsGeRJK5jmh8UR1FR43IsNfYoeEse8HBZ50upG9BeIKlcU3
         Ix1V3kZwlUo1iKlDNpxjOmyPti+8wGF+qmY0hkLkO54+5sBKxAz66kCX6b/UCg0w4rKV
         YOrusaDHrNVHf85y3T7DECiJ0k+APxrgoh0Xf5VPsB6z517GK0t0BeN2o6f8frN54utd
         /OGxO000UtNVnSZnSYUxNKiWwxye4oXIHDUPgeFoZA/+7lJfrqv15zFr7gTDAQjHBWNK
         NbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2DFUWZMjdYCRr74/VE0fH9TXzYLb8WHFi/lJO7XkynM=;
        b=cnVVeo9cXvKz0jEf1+1TGnAJMAerQ1W5JEPVFd64G4W4yxGvtXVQFXOCuW/G/qy1La
         iI7g5dWY3Jle+NBhdBqjcfhI57ZUAX4xlXePIUxleOgXJTgVr9UVd+s0LjPYuIR+Fh9D
         68jamUnb5OEryvsCuFwXtXJKHt/yDMe2yYzvlrptt0YLMHIYNp8G5u8w+bVl6q247yep
         ITv84jr3BHvo9KzBA9J2TewjA6vjnMEyspnlQyH8K+cdT63JB2Cgu75QXXIIcUtpdFLg
         +SrNNHggffqezt3oMssRaCQKSD2UBFsfAfSXBiJJ19J097cOugIjL2aMKY3xHXtN6g/0
         UkYg==
X-Gm-Message-State: AOAM530o2VGM/OIJT9T/QbBtY4il2kkRFyb25mBIpMdcYviWkpQX/qVq
        XmRn9SENmC8NPvma51WM/rdkhg==
X-Google-Smtp-Source: ABdhPJy1OqOJkyDQAwpboLIY8PUhJu0iOx+QcG9P521mi8o39xl0TuUmwFrSq4jOhbL0Uncp31FTCA==
X-Received: by 2002:a0c:e1d1:: with SMTP id v17mr27799220qvl.15.1604419080903;
        Tue, 03 Nov 2020 07:58:00 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d7sm10653153qkg.29.2020.11.03.07.57.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 07:58:00 -0800 (PST)
Subject: Re: [PATCH v9 27/41] btrfs: introduce dedicated data write path for
 ZONED mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <72df5edeab150be3f081b0d96b174285f238eb0f.1604065695.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <1d3b3244-9b30-450e-66b7-0bef71842bd6@toxicpanda.com>
Date:   Tue, 3 Nov 2020 10:57:59 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <72df5edeab150be3f081b0d96b174285f238eb0f.1604065695.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/30/20 9:51 AM, Naohiro Aota wrote:
> If more than one IO is issued for one file extent, these IO can be written
> to separate regions on a device. Since we cannot map one file extent to
> such a separate area, we need to follow the "one IO == one ordered extent"
> rule.
> 
> The Normal buffered, uncompressed, not pre-allocated write path (used by
> cow_file_range()) sometimes does not follow this rule. It can write a part
> of an ordered extent when specified a region to write e.g., when its
> called from fdatasync().
> 
> Introduces a dedicated (uncompressed buffered) data write path for ZONED
> mode. This write path will CoW the region and write it at once.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

This can be modified to work in the way I described in the 'split ordered 
extent' patch, just flesh this out to do all the work together and that way you 
bypass all the ugly splitting stuff.  Thanks,

Josef
