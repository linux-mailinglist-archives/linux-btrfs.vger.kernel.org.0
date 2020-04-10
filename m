Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6211A4A53
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Apr 2020 21:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgDJTWt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Apr 2020 15:22:49 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35117 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgDJTWt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Apr 2020 15:22:49 -0400
Received: by mail-qk1-f195.google.com with SMTP id c63so3245672qke.2
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Apr 2020 12:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hQTyhDUGNWY+2vY832LY8m2QdJZh5HwVSeRffKOPmc8=;
        b=bImjK3L51xIjlqbeYH+mT6Irt1470WDoVRoMZcoOkbAra5bbdqiVJI3OCJZVoHsRGt
         hvtwKcgOC0Qc9prFLIzYhI4/24qEL930DmEtFsIgtfbBbqzgM/NV2OnKBaWWRTs7SY88
         +9jT65MJJCCwnqN6bzQMGxlO865UtKp+chu8sMEUCunx6X+St91TiI+hMShygR5eXwP4
         ZrgbBKauRpge6/gofOCazZlR3v1QI0jxeEJJHJ4L0H9bRYmK52f97hsOLuXBp5pURnwk
         0h7zr2yK8wnSKyKubdwu/JFAqDNx7NGos6ja/mGk9oEOV9qOtPDXPX8uIhkHH+gQVhD4
         2RKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hQTyhDUGNWY+2vY832LY8m2QdJZh5HwVSeRffKOPmc8=;
        b=VsiVORosryywBs3QDo8WJGCkuSzq/WlOzdVmrkq74gSO7L7Y2JRQDXVep7FZKFysrS
         8JKtLiFu/pnynOgIE+JIjJExUj/MfGyvxM5YiLsil+YF3sqIsFnFFWR/RbPfwb0U3RrW
         3esCeVnHnNB6eNWmzkSZBig+OsBzuumztCud1Wy8w0uCDaa7lajDAdhXZFREPH8gUTCI
         6maCTLmBrBzwcyEK/pS2ZvislVDG2ne3WD5iadTPE/+iJEmyhZw8MG6sIsn2CW2xU0MC
         yessJcVHbysrBcYjhvkWk+pZUUUBsuMB8O4xXpiJQibMGjcw7DPxMSCRuxTIU/HDfuMu
         KgMA==
X-Gm-Message-State: AGi0Pub9YsNlZUtJUFiW5+v4d6nwhbcx++7Bg2poV3s5q7WF0DAUVL78
        lvWBoYLuFP/W4i8GJlTCb+zvHQ==
X-Google-Smtp-Source: APiQypL9H8PFloon/jvIQxeYt7ZlVMvxdRczru6MXWOyVmZEFcn2fKQqcGFPfp7SAY9O1lvZVIHCZA==
X-Received: by 2002:a37:8603:: with SMTP id i3mr5220048qkd.303.1586546568851;
        Fri, 10 Apr 2020 12:22:48 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id y21sm2203519qka.37.2020.04.10.12.22.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2020 12:22:48 -0700 (PDT)
Subject: Re: [PATCH] btrfs: check that cloning an inline extent does not lead
 to data loss
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <20200406105134.2233-1-fdmanana@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <0287777d-39b1-c11d-82bb-d68cdef54df9@toxicpanda.com>
Date:   Fri, 10 Apr 2020 15:22:47 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200406105134.2233-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/6/20 6:51 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We have a bug in the current kernel merge window (for 5.7) that results
> in data loss when cloning an inline extent into a new file (or an empty
> file. This change adds a test for such case into the existing test case
> btrfs/205, because it's the test case that tests all the supported
> scenarios for cloning inline extents in btrfs.
> 
> The btrfs patch for the linux kernel that fixes the regression has the
> following sibject:
> 
>    "Btrfs: fix lost i_size update after cloning inline extent"
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
