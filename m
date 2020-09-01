Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23563259F2D
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Sep 2020 21:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732720AbgIATXC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Sep 2020 15:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729441AbgIATW4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Sep 2020 15:22:56 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5FBC061244
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Sep 2020 12:22:56 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id v69so2084734qkb.7
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Sep 2020 12:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=3bMmju9kl43VabbamkzTU3yRSz4vtWFOtk5ARNsll0c=;
        b=mhVnCgnygpkq4igZxPRgXiH3W63iBcveHetHNp4q2VLn67BiHxnXT7CH5wvHUV/ZJb
         YQ74KVuht9E90QwmA5wB8ztaSBndODzMaCvQTCgTJjKADrwTOwTnIu/Ih6HwvaaAhXAA
         zM7M6OcEbLKl/doF4DoC69kTw2BSx3GzY+Fcodi4/zpXyOJDULVsgbrjAQjhtFqerpIK
         D49tocffax/5z9H5S272FsNa9fThW+NbtIbz4B4WitqAwe2e29lHbUntMSxZjxJFXAC9
         hbcV80DOHcElYAzTRB9NzbAPSmr0YIeYEFzMVebuGw6prqPdyJm5lksMa/5CMOEbVz4X
         rB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3bMmju9kl43VabbamkzTU3yRSz4vtWFOtk5ARNsll0c=;
        b=Q5BSd+Jbvv1iGkGI4sNBjav64CBYna5B2nwQoAlpm6b+psbwOcyJPyPB7UXyAsvf9m
         bF0yGWPfcN4j2dsc+QAsu5vjggSEcNyV+5qcgA0nD/9vuRqjpDP7VlaWfDHzPyZXX35o
         olzK39mOSG9aNtys2loAl8ZH0BEEpAaXPng+brGdGdFZYpFPz1//cGRqHcxqT6jD8COb
         WmWvWiAHYZRc/msbv5jh0pOlf1srpxYxPqKudoOinbEB/FyJ1swcTHoFtnyoLoSa8UXX
         bI9I6cXnACJZY8yJ5mVff8q5LPmp2sXHDB3ihkfB4UkZ13drWh3J5c6+JOVoGNkBcnht
         6Cyg==
X-Gm-Message-State: AOAM531DlkJSbAM7GiovxcuORRUkhxE5FKR8QejHMS0pkl0isHD3N6Sn
        tbO0XL9LdeJZbRc81rdSECDOwZp3wLBtr+Iv
X-Google-Smtp-Source: ABdhPJxYuZvetZNdCj56UBzby8jNoJyvriO53FX/WnjftV2k3nbnpQ2CRTmLxDLDOrKf32JwVRDXsg==
X-Received: by 2002:a05:620a:c97:: with SMTP id q23mr3567890qki.168.1598988175702;
        Tue, 01 Sep 2020 12:22:55 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d10sm2706869qkk.1.2020.09.01.12.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 12:22:54 -0700 (PDT)
Subject: Re: [PATCH 4/5] btrfs: Add kerneldoc for setup_items_for_insert
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200901144001.4265-1-nborisov@suse.com>
 <20200901144001.4265-5-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <631ab565-b483-453a-4c21-6ac6ef2b4fe1@toxicpanda.com>
Date:   Tue, 1 Sep 2020 15:22:54 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200901144001.4265-5-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/1/20 10:40 AM, Nikolay Borisov wrote:
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
