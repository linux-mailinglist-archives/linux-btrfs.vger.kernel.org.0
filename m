Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 269D31548C1
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2020 17:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbgBFQDo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 11:03:44 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40685 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgBFQDo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Feb 2020 11:03:44 -0500
Received: by mail-qk1-f194.google.com with SMTP id b7so6016021qkl.7
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Feb 2020 08:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=auM1D6XkmuTWoAnI2coioQdaLdPF1YSkzr7zrBrEwas=;
        b=WQBoHKhC763PVLixj0hPEN8PIG6tDU+lgk97gN5E9kveHqzGwcUyLPMJJaqQjjZ6NS
         K/qnsr9C54SXr2jbVhNXChpXvTJkEawU3KJQNSHS/TKAMruUOUMnJmqkpHM++s775/Nq
         JULgUhrFsZ4BwPki+cJDeCzRSqQe4Xu7/DYulubjrCl8e24OQ/Z5DgdCV4heaUFD/hTH
         kPk52I0cf7DFUFh/7soSfkqcFpA491cxVInO4J2ayyM24xjdHylxpYoCc/0p2/f77DIt
         8BTOh/8MW6QbonKiCX3pz6b2LDYajZP8MLTK4CcvyMxl2UpuMpvFO9yfnkSHUd6xWOYf
         GuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=auM1D6XkmuTWoAnI2coioQdaLdPF1YSkzr7zrBrEwas=;
        b=C7ItuhAW1t4Sq8uUfJumLAW3mtxAHjM1Ori5TuphsoUrhdylwf8WDKgKuTU9UP8tI2
         ARxDZU2Qk1Vk4LNoVrRXgEFec6GEjWMLm6n13fJdq5RQ4Fd/N0UlwvosJ/wRnBxlidr+
         y0sPdUtnnyznLzbS9YCzXuxOSv0hipzoOh8B4qDXwYNv2NDBrhPwbTtEtpLDn6AHHP1p
         xTa7u5/h2G/DMM3o1SYljf0RIaf9y55TB03HAfqjap3hE8/Tgr+Bzke8qkKvjgmGu+Fi
         WQtkth/v9ReZMLcgsTNWeSabdsLp+NCKqFSs+ANUMZP3u8D21rq0FqlF68Cb/8rRE/9L
         3DMA==
X-Gm-Message-State: APjAAAVtYGJIpAdnXmM7CDZJ97N/FvNoU/mqf6fS76UUa2Ogln32zOgK
        a8u7tRfYiRCdWrMF4stwE/lFww==
X-Google-Smtp-Source: APXvYqzpVLG0Ivic4pzG3Bnusjsr/tgABOuEpIHdJh+WJ1iPZqfwSRq8tkcFe2M8rDrfTmb1K21vVA==
X-Received: by 2002:ae9:e306:: with SMTP id v6mr3163469qkf.162.1581005021680;
        Thu, 06 Feb 2020 08:03:41 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id s20sm1593316qkg.131.2020.02.06.08.03.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 08:03:40 -0800 (PST)
Subject: Re: [PATCH 01/20] btrfs: change type of full_search to bool
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
 <20200206104214.400857-2-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <ea9e9901-c314-2f39-4802-716eb32eafcc@toxicpanda.com>
Date:   Thu, 6 Feb 2020 11:03:40 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200206104214.400857-2-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/6/20 5:41 AM, Naohiro Aota wrote:
> While the "full_search" variable defined in find_free_extent() is bool, but
> the full_search argument of find_free_extent_update_loop() is defined as
> int. Let's trivially fix the argument type.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
