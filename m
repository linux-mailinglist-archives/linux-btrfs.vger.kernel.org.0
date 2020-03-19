Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEB1318BA51
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Mar 2020 16:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgCSPFt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Mar 2020 11:05:49 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46172 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727632AbgCSPFt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Mar 2020 11:05:49 -0400
Received: by mail-qk1-f195.google.com with SMTP id f28so3290328qkk.13
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Mar 2020 08:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LA20mVyLb2SaOL1wyicfD62bc68k5iCzZRchiEvpGCA=;
        b=v4eMNCFwWefWrRdZTVNOgJmXRdf9WHYBIPg+X7EndEUcjcxD4460Dn3LHVu8MW1q0A
         RtLYre0VqYhuF434r5H5z2XvVF1pdoOP3TLy9jtZWKMO2KZ/ezwINkMBJn4Jlt+MEKas
         4t9NwciW78YmZqWZJDsyZjqp3R+ZQ9z2ycu/UXkj1faZ4x4Y2Mhst5mqHhbNp2EGjCeN
         JKLYvqnXVkr1V7lZKgV1TZMjooim00cPyDVQsbypovZJB++/wXOquJ3IlGNigzFy/1jF
         eTPR+JU9WgGlvU5CEY0QNLRj9JkjjiJ0wfXi7Hbp/nuDcOr86dabmCmPNZrOnyDsrXbg
         1K2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LA20mVyLb2SaOL1wyicfD62bc68k5iCzZRchiEvpGCA=;
        b=GlibpUIOKeMJKPUBEw4bUqMPR2RnrCJLUnj5NyUtfx42D6vXAuZgycagFEvduhmr02
         sPuSCqlO1tmeFwg8Pr8/+nsM5Hzr30g9rEt8ogD3BBGA1mOPL/VR+1HVikFS6iAEPvLl
         8gxCnZiz7pg18AvrFsEzFFeGPNEX6fBF50nTWpmp01NFS8cA70uO/q/NQd9sywCQ8VlG
         Fjj7UaXs75S+YVZJmuk6tD+hxiuj02i0DoBaMpsHeces97keU5nWymJWpJCpSSBS4zRX
         V1r4E84upztm/NaFZ/mqId1sa1HyZ/KrjPbQdB5V4FQWYrkDMPCT8B8b9X0kow725jbi
         oHhQ==
X-Gm-Message-State: ANhLgQ1bgp02pIbz62KcRRkmkE+7g0SzkFUVqRKMA8GU1HQYXZF2xvMJ
        bZjQo7eLKHdxq1W7oxLYBV2Rn4FpKXU=
X-Google-Smtp-Source: ADFU+vtHrDCC+swp6IOHpEBF2bKdiOn9W6m2KTUa2fvLF2TEufmsQcbAACM9bivpuiYE6FtgMhr3XA==
X-Received: by 2002:a37:8645:: with SMTP id i66mr3319500qkd.91.1584630347461;
        Thu, 19 Mar 2020 08:05:47 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id n21sm947639qtn.17.2020.03.19.08.05.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 08:05:46 -0700 (PDT)
Subject: Re: [PATCH RFC 02/39] btrfs: backref: Implement
 btrfs_backref_iter_next()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20200317081125.36289-1-wqu@suse.com>
 <20200317081125.36289-3-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <f71c0b80-9d43-0547-dcbd-8d65aa0831a9@toxicpanda.com>
Date:   Thu, 19 Mar 2020 11:05:45 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200317081125.36289-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/17/20 4:10 AM, Qu Wenruo wrote:
> This function will go next inline/keyed backref for
> btrfs_backref_iter infrastructure.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
