Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C60F1728DC
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2020 20:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730750AbgB0TkY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Feb 2020 14:40:24 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39142 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730673AbgB0TkY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Feb 2020 14:40:24 -0500
Received: by mail-qt1-f194.google.com with SMTP id p34so190971qtb.6
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2020 11:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=D+c8KfSM3aqWDshOjJabbMx1pY36aGDt9UI/cse85PY=;
        b=Fgcl1mWu7/RDmtoi0akUlgeytST3UcqvCKddeR2NYAMbP8oZGo0hL86YVipAxP8/hW
         +8Nz5Zjyu6OGSyZq8BCOo7lOQgXEVUTZKzM5n56tPHiL5jXQqDZ6zjEfcWx12V7HOJTV
         /Rs5LI8k1Q5QW0X8vYe7XM2rpHoN47NO8RkrxSg02EMtCg2cotHPh1sqGI/cazOj+Rmt
         3hBf98uPri2rlM47zp5T26fz75Jm09LHm2Chkn1mDXqfQYVsg7poNABYpdrkZMd9ux8A
         nqzGGT9stVgwc0m/Zd6upVil8PzDZu356C+ECkN5FSzpekGNsOcGrkKtP84DW3oTK6E0
         1qgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D+c8KfSM3aqWDshOjJabbMx1pY36aGDt9UI/cse85PY=;
        b=eDIa0n/XMARQ0Ylup5YJvNz29sQexFVrLbvzfXM7YZDyJ5UcohFgY7rFH7OnjtoRcB
         yjo70DiWwDPJYyinDrQAwQg4vRUWBqMGO665D7D+EKVZ6UVe47gQbmRCilpm6op5kzu7
         fbnPUYq6pa+c7KYcfyp2xD76TYtvaUUezcbxWzfLARpUAxPDtSQER/x/hBLX7esuRGog
         pkvJrGUxsKLErPL61zIRyy0oa3O15EbLlvnUYfKQUgJXlh98vIqWzJ7BGBiryp0MI1e7
         Hvyq3hyoxR++foOqUVr5nQDYNMtBpq8jYDR/OmlHuh7xOzuK2wd+CaR/QAzjDtjW4enQ
         FXEw==
X-Gm-Message-State: APjAAAW6u4CkQvfw/Jya/qAqs0zg7Tr2BySojSUvb11rEZpAAmUNcQVm
        f3OLxPveqgg5JCAURLBcW7DYEvayLGU=
X-Google-Smtp-Source: APXvYqxOwGpsOasPHYjExJpSYw3GQGB5eDdbagwUVX9LK28T8I3C30CKOV/Y5NJ0AUDzGbORygmcbw==
X-Received: by 2002:ac8:7b9a:: with SMTP id p26mr866137qtu.281.1582832423153;
        Thu, 27 Feb 2020 11:40:23 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id p16sm3682568qkp.12.2020.02.27.11.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 11:40:22 -0800 (PST)
Subject: Re: [PATCH 2/3] btrfs: relocation: Specify essential members for
 alloc_backref_node()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200224060200.31323-1-wqu@suse.com>
 <20200224060200.31323-3-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <41b09202-cb24-05ae-b8e9-65bcd62ee887@toxicpanda.com>
Date:   Thu, 27 Feb 2020 14:40:21 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200224060200.31323-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/24/20 1:01 AM, Qu Wenruo wrote:
> Bytenr and level are essential parameters for backref_node, thus it
> makes sense to initial them at alloc time.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
