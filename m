Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB92265005
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Sep 2020 21:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgIJT6o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Sep 2020 15:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731205AbgIJPCn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Sep 2020 11:02:43 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3038C061573
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Sep 2020 08:02:26 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id cv8so3465165qvb.12
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Sep 2020 08:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=DYKRmulMzl72FW9/jc7DfBzP8iJUTOKxLvvI892bJtw=;
        b=MQBGQF4KMaI5uWHjEsal2bnEyYLAjdULzLXiM5r0go3bvxpVEhZoSoRJ/EZnEmvEvx
         EMO2QdGgxMeFGUgGxgdn+YRqWv6OZnYthaAg4+7qUc3aWoRM+gxL3xITcquY3niWbKCN
         5rHrJHujqNox4gaf4b5+tcogu+5+zb8Iudukg+ff20mqjHvSjuFDmMIwzmZIYRiQSmq8
         yUcHb0iM38h5WyxqTJoSTLZsBhcm3Da6ZrNH0/N6eC3YesAFHne1WmYtTLoLDcqEsJ93
         N46mErZHG8d9/N6lsVIUpgsqU2r3hjlXTKyA6Dzva02dsVFHxKUqwyzt1lxmFT8QCtIc
         v8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DYKRmulMzl72FW9/jc7DfBzP8iJUTOKxLvvI892bJtw=;
        b=TlyAeARSQ+cW5cnjs6zVeft28EwY56FmkGv6KndVmbFbSshzdmP4VmUb8DcDouDePJ
         TTDF2WYktkJm4aoxEQaMyq+xTBW/UnOfy0B9ioqyLLC8Dfi+2jyPvrwCJw1v2/GUNNSq
         ift4XPCR0/dlCn7vNNIvcFltTA+on4I1IpXCfxfpyXPwzSGojuafTdkncODAuD8Gx7SZ
         URQZcWmb348oHkqLPPCnAM9hIjQHBa6/VRrS3AZufAplZO0KFkjoYfdvHfFX7vXahRTx
         PIVgXnBX0ygavNCZlXiPZY0UvvZeOS1ydHvPj5YBCgPq9gXkPpmKVeaDn9nsmEwsn3KG
         9LDg==
X-Gm-Message-State: AOAM533t3vEFsD4UUGo+sAI6jnLAaVmtWPCI/mM2BAYOFmt2XDLsWOKf
        YYkGSthvx/5JdpKz1HPw5FHkky8bv7BK6t8X
X-Google-Smtp-Source: ABdhPJyxHkDScAVD9FXuc2ARqVNlYwIGB4p421F6vn+aRrRdu3yWtNAKPdV1VsP78pmQEVTTpmxArA==
X-Received: by 2002:a0c:e78c:: with SMTP id x12mr8716023qvn.3.1599750145865;
        Thu, 10 Sep 2020 08:02:25 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y69sm6780129qkb.52.2020.09.10.08.02.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 08:02:25 -0700 (PDT)
Subject: Re: [PATCH 08/10] btrfs: Sink mirror_num argument in
 extent_read_full_page
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200909094914.29721-1-nborisov@suse.com>
 <20200909094914.29721-9-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <0e8e948a-7d47-2b9e-5699-39c3b6c571d3@toxicpanda.com>
Date:   Thu, 10 Sep 2020 11:02:24 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200909094914.29721-9-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/9/20 5:49 AM, Nikolay Borisov wrote:
> It's always set to 0 from the sole caller - btrfs_readpage.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
