Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6D02181FE4
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Mar 2020 18:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbgCKRrI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Mar 2020 13:47:08 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]:39407 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730493AbgCKRrH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Mar 2020 13:47:07 -0400
Received: by mail-qk1-f172.google.com with SMTP id e16so2932034qkl.6
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Mar 2020 10:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FcqiswfdjqetanoyQsWUUD+OLgI+FTzG1aCM5ZGvWYg=;
        b=AqDvoP/QEi9hL3qxS+Q6NQqdLHK6wx/DwZwjykjXX+QU/8IU6Clrq4p8TaG/id0TTZ
         VyomtFSnvyv/lAeh4Lsmg1f4X9VzpmX3U1PaPKcRtJiGrkWBwBILhR86B/fET7z8uWhm
         BAi2SKbsN6tMiMKt4tPNtR/V6vSjINs8/XjW74rxGbk9rKjYdeBJupFELQUiWSGmAiv4
         0wLmKEwZMoQEICqwWHevYHJZPaGZSVlbwg4CdFk5TNioLZaanqizjQ5o5cIDYM326uA5
         a6ysIE2aKpW+C1jrh+QPJ1DAG78NmMHU26oe/+Ijy2NNf4NuptR4pzpJO7ql4iRttY9n
         wrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FcqiswfdjqetanoyQsWUUD+OLgI+FTzG1aCM5ZGvWYg=;
        b=IKlCmj+9b57KWSPdWlaKX+cDs8R4kQ+RHWSC/DxdA6NbgaduUE8W9puk23igf1pUJf
         ZGwOfZCE7LVv2/ZLxsg9w0TrI5PqNCiG1+AJgmG4QaRVNVwqvsyhv3B1Gk7EEdOn6llC
         QjxcjvzVsYYiPxpAqmOdfNWTxzJSygNXxLliImbGFZouIkcmOVf0lzCNnTx3M/Hti3w0
         Tff6kzGPbpiDRY23JkyERRmxwWc5JBgEMDATesVz0YiBE9JJdGyENrFIfKpDWjSvI7eB
         /LDKceDJ6oHw9rR9MdaywmTz52LnU/9zbUPNsd3PIXVevEuLnij0dh3XXg9XdG2wRI18
         GT5g==
X-Gm-Message-State: ANhLgQ36TOx+7O447AusAtWe0nVg+NgCTuzezpAQMDPttFAm2Tn6f3JT
        Its95cVmN58i+t3bilA+/yM0kg==
X-Google-Smtp-Source: ADFU+vtCpeU37ks6JXcL0kuNFs5hanjYoDYD6WeSows5XS5HyohbXIunN3LiNqne3mdWrFZ6Ea8t9Q==
X-Received: by 2002:a05:620a:6d9:: with SMTP id 25mr3842870qky.457.1583948826431;
        Wed, 11 Mar 2020 10:47:06 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id f13sm12113841qte.53.2020.03.11.10.47.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 10:47:05 -0700 (PDT)
Subject: Re: [PATCHv4 fstests] btrfs: Test subvolume delete --subvolid feature
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>,
        linux-btrfs@vger.kernel.org, guaneryu@gmail.com,
        fstests@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20200309103956.1697-1-marcos@mpdesouza.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <085200d5-451b-e58c-0a3b-634d12e0002f@toxicpanda.com>
Date:   Wed, 11 Mar 2020 13:47:04 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200309103956.1697-1-marcos@mpdesouza.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/9/20 6:39 AM, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> Now btrfs can delete subvolumes based in ther subvolume id. This makes
> easy for the user willing to delete a subvolume that cannot be accessed
> by the mount point, since btrfs allows to mount a specific subvolume and
> hiding the other from the mount point.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
