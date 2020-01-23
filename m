Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6C6146959
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jan 2020 14:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgAWNmE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jan 2020 08:42:04 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44748 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgAWNmD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jan 2020 08:42:03 -0500
Received: by mail-qt1-f193.google.com with SMTP id w8so2421908qts.11
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jan 2020 05:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Yc8TWPGag9U2fJeHSrtvYYio1chKX/C/ooxMQUJejx8=;
        b=o0OSwyAv5/wjd7VO2Xd4auInSz/Q2rXM6StLJMN6GL7dDssD+EYL3fFUCQ4CuC5MZn
         5luvr1yL2R6AcbnXfHzh/wvzuu5tpMC32dXV43kIoExlX4kiHhljE05WbCV/rQB0jJxS
         ulRrnT7f6HIZuT8HXwFZiG4MEaYPGMY6mVMk04VdtOEPRDRnPZAr+Li8Je0VznleX9CK
         tv9MjLKI4FVgFPDXSeNVclpVIsTY2zKj2Xm3Sg98DGIMa2Rj/SNl43x8VTvluB3lXkzN
         uahHcTj/PZ4KuVYTUFwmEPzZwrPdWe3vG7jwzsrfpRzzzIJjexcaMDQQZ5u6+ayxeQtQ
         htbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yc8TWPGag9U2fJeHSrtvYYio1chKX/C/ooxMQUJejx8=;
        b=i9tpEKc7fGE33S3QtwNR9U0veywTFnYtYwMZTNpC7OIEOAkts64ARQV7iIswoF3/YV
         C8AT5Msgu6LIwZwN7j5naJY6AhJ1Lzj2CcVToU/M2VuCxq0SMeSYVu1Cq5BqZEFgn/B5
         RF56ylVc8oHeAKBkSbVrHc/xmajhdqWaAEfQO5TV9FEZAH+oOnUkCGl2OePr0P2annQC
         N8Mg8qDWOr9WGz8P2yn/wUcDC2Z98443U/lZgfHj9Gu4fWu8rLASh5tM+6+ti6QWdMnn
         pnzsdr+TR7VS1502E+vmLiB+vM2nqlGK+F3+pojFZxB4SB2eHvaEOKt6mjht28lo/uqQ
         pfEQ==
X-Gm-Message-State: APjAAAVHLcREgSpq468HyRHtKg6JXAECqJx1WoDVNKY7nhQeMqiPPGIy
        UhaHMkH+5SPxUqdiAYyuq46s3fs97tLfKQ==
X-Google-Smtp-Source: APXvYqyfBTuPs2MVu2DwUDBIE8cfIrK9doBquKroPW4RfIQYcaPTiGubwt8JHxgK4nHPvsWsr8Usog==
X-Received: by 2002:ac8:7088:: with SMTP id y8mr15392720qto.325.1579786922253;
        Thu, 23 Jan 2020 05:42:02 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::7e55])
        by smtp.gmail.com with ESMTPSA id p19sm937916qte.81.2020.01.23.05.42.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 05:42:01 -0800 (PST)
Subject: Re: [PATCH v2 1/6] btrfs: export btrfs_release_disk_super
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
References: <20200123081849.23397-1-johannes.thumshirn@wdc.com>
 <20200123081849.23397-2-johannes.thumshirn@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <57352627-f9b9-5992-348c-b6173cb31a19@toxicpanda.com>
Date:   Thu, 23 Jan 2020 08:42:00 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200123081849.23397-2-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/23/20 3:18 AM, Johannes Thumshirn wrote:
> From: Nikolay Borisov <nborisov@suse.com>
> 
> Preparatory patch for removal of buffer_head usage in btrfs.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
