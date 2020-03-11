Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 443F1182019
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Mar 2020 18:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730450AbgCKRz7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Mar 2020 13:55:59 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44602 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730363AbgCKRz6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Mar 2020 13:55:58 -0400
Received: by mail-qk1-f195.google.com with SMTP id f198so2939820qke.11
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Mar 2020 10:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ROfAfmJP9ongOo63v6EULnAXkA3FevQ5rrTuxaWmgKo=;
        b=XBAuBTkiMJsc5HvO3/3dqYi2F/2bmxUnps4xdJhyPg7UGGrooIYo3NE/hfDN78uDgk
         YaIFBv3ig6MtgHozTIcpNboK0HBQU/3V5B0NgEEHALeRPsKcwysfnDy+viAQWEOmI/FS
         vUscVGacB4H13xiBlJ5IEZU/yVzCefDpu1ACIQWZimQi6lA1qCK/0uISSilLGy5ILrsr
         Nv5jzLyeBfOrVcxzBZ7uDMgEWWxf5nmH6Grm6rFCWZKBf/NiZbYnyDB7o1zjwPNOn4iF
         qqKJRKVJSxRSDaAvVsV04f3fkjn0pIaO41/feqUqQQFLIDaFkP3lhdg/z3ZQJL+O2Ryx
         gBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ROfAfmJP9ongOo63v6EULnAXkA3FevQ5rrTuxaWmgKo=;
        b=qlMxJu41sY5A5qaDw0nvSIo4QR21CiY/FcYOq5JFxpf5xO8W3xXwMlsZU1DyZh79qY
         5C3R6FV0XJqXfzZLhONtxwPhJej40BuorNJ8uWE/O+3Y/OYtcJTefRdhF7RuOdgYY4fc
         VrC7dZrjAmbXfMzj3G5CuNB4qKNUcpI+bbKvkWojk8x5+ErAMLL1HQCfcOTOUSQtxToZ
         RWaRiL/s8iB3MKgw29uI78dhCLVfzKit8NlR9VykuKj7DYO/SFEtOsyajtRPdCTwb0UK
         grRl12O1sUnxCMGcitXbjufHXMEsTlM8Kz4eoPX424yGfJSJEqgfyhsMDoJXUiXnLwar
         utPQ==
X-Gm-Message-State: ANhLgQ3NgVZkyCnrR3V/DMDu7CnhH9Z6sj3nxmj+xyCZFUK2S/e6Eht+
        MgdpBRm+dfh2ySo86LhJZChd5s9d7tA=
X-Google-Smtp-Source: ADFU+vtdepWiboR/7rICvvaILR5SKAxoVpRXn5HY0m/HdMWwJfAre70AePJpzMPyqmIxRfY9jq5uKA==
X-Received: by 2002:a37:7746:: with SMTP id s67mr3779546qkc.127.1583949356225;
        Wed, 11 Mar 2020 10:55:56 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id a23sm25794676qko.77.2020.03.11.10.55.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 10:55:55 -0700 (PDT)
Subject: Re: [PATCH 04/15] btrfs: don't do repair validation for checksum
 errors
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Christoph Hellwig <hch@lst.de>
References: <cover.1583789410.git.osandov@fb.com>
 <b1ab11a92dceaff04ca6269689584c7ab9045674.1583789410.git.osandov@fb.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <8a0aec92-7798-bd8d-a7fe-23376036ff5c@toxicpanda.com>
Date:   Wed, 11 Mar 2020 13:55:54 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <b1ab11a92dceaff04ca6269689584c7ab9045674.1583789410.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/9/20 5:32 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> The purpose of the validation step is to distinguish between good and
> bad sectors in a failed multi-sector read. If a multi-sector read
> succeeded but some of those sectors had checksum errors, we don't need
> to validate anything; we know the sectors with bad checksums need to be
> repaired.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
