Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED7C818BB2A
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Mar 2020 16:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbgCSPbR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Mar 2020 11:31:17 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40915 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbgCSPbQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Mar 2020 11:31:16 -0400
Received: by mail-qt1-f193.google.com with SMTP id i9so1499894qtw.7
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Mar 2020 08:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=jrcq++KPrbUZwOC7/t1C6reoLQM0bgXpW6tlpD2Lkjk=;
        b=uU4gJMXC25oxm0QpGWSztseY69APBLG9GQ3BVIq/SIDHhRh4kPkflIzkFKvx5qzg4Z
         24QMcoNaar79bWdwfzrL+LhgNMdJqsyEWxWdg/Z/HLWXVLleDFrtaeQwmd7ctlWcUteC
         WJCrPl+0r+0Vd2bMng5XCbF7RgHWDAigm9/YLmeB78isvkbitFmAbvs7ai1bZVh3jVRU
         vpLjL4uTX0ckWMfVrWSF6Mb9oyL336f5m27ri3ZsC3WvnOKHmaGcnBMfXPyMGGvOCnC7
         KMkT6QSLpv/iosCL0wCZx6QuR4PV9J3yXswzi6Ru6Bq3ezWGS6Djsfk65a6AKVURjWb0
         4V0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jrcq++KPrbUZwOC7/t1C6reoLQM0bgXpW6tlpD2Lkjk=;
        b=JTCWlHU/De1knOqAW7JbjkbYSaam8zCGbBEQGkROR2kDPJVeh3VMKO2ioUDFupxq4r
         YoMuy95RPIANc1T1lT6F/u8vI0qYPFOsr2AqcXMDgVDZHtUU+otPGgz1+quqdPUFlXnQ
         h1fHXVWIyzk8Z1yQ0VgN6BDDBkAkbYgz7iVOaqpkCzyrkAK1qaioTBhhVOMM0A1GTlEw
         KeCUmLBZph4Gm+SMwiFgKuwDAV7/kldqrO0zznTAmAN9CwGN0tuGTK03+67CwMpLjtJE
         G9Jjxio8xeXup7b03tcmQ44CyiLGaQfRUvbQq7tRT/TcCrgYcWLKYiEE23x+baRiSM5c
         OhgQ==
X-Gm-Message-State: ANhLgQ3VfPqTddmVvKCvvWx1tr3ZEs6KcgMStLUpk6wLdJvQ5M57DvvY
        m9+T4VjlQWEOLUMWxIYa7chJRiUcT/M=
X-Google-Smtp-Source: ADFU+vsoCqoM+11c2kL1kYkf/QhDRwSYgLk0wMME/BjIwoPCzqScq6ihtnSm1H8FchLy4ny4PctoxQ==
X-Received: by 2002:ac8:4787:: with SMTP id k7mr3501827qtq.267.1584631874987;
        Thu, 19 Mar 2020 08:31:14 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id y27sm1655047qky.121.2020.03.19.08.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 08:31:14 -0700 (PDT)
Subject: Re: [PATCH RFC 08/39] btrfs: relocation: Refactor direct tree backref
 processing into its own function
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200317081125.36289-1-wqu@suse.com>
 <20200317081125.36289-9-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <f0cef203-83ae-348d-9f45-a4436fe0dc6a@toxicpanda.com>
Date:   Thu, 19 Mar 2020 11:31:13 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200317081125.36289-9-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/17/20 4:10 AM, Qu Wenruo wrote:
> For BTRFS_SHARED_BLOCK_REF_KEY, its processing is straightforward, as we
> now the parent node bytenr directly.
> 
> If the parent is already cached, or a root, call it a day.
> If the parent is not cached, add it pending list.
> 
> This patch will just refactor this part into its own function,
> handle_direct_tree_backref() and add some comment explaining the
> @ref_key parameter.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
