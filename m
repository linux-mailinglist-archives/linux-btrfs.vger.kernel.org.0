Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C82F12D1D6
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2019 17:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfL3QRH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Dec 2019 11:17:07 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44459 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbfL3QRG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Dec 2019 11:17:06 -0500
Received: by mail-qk1-f195.google.com with SMTP id w127so26548456qkb.11
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Dec 2019 08:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=qnR8W4roxRgJ2oXSUjhPddje1GvlLsbG7OBDLEMVtWU=;
        b=e8roHMtCTpJODWgNu5hzPtjc7ACet7TJ3MXwc6G0TE1xeLbRl6FpzGaqldhPgr3kPd
         hl4rdR9T3iS9l0Wa/a3PA3N+TuLFjU6FOLtULZbM+hPOafPMkr7QPVY7oF2zAgC95mEM
         QxeXZMnhQggVrgwkd6+NNHSIlbOwj7c65bAHz6x4RKrVaOTiDMwh5GdM/PwNTgobb1F+
         r0fxlcz9lEItDxtq+1pMLWIg6qfp6YZqiE1+8TMkd8qRDkmKZX34m3S8kUS5Dpy8isgl
         zjYnPVDESJowvEYM5PkxmeempW5iv8o/qXVK/JbiIPINxHyjG6/6REUsR4jVrDmm5bH7
         99Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qnR8W4roxRgJ2oXSUjhPddje1GvlLsbG7OBDLEMVtWU=;
        b=itzT4qfzRQFHGrjuQ7d0UbW7QUts8RAx+M3kdtpoCKZ7fhtJAazpR8BWvDTf0edYcB
         h/bsBNpWWaNRSPntVDIVDXc+u1iOZBulEW29e9ueb09tTHCHQiqQ+c21nsshuJeGqNO/
         wSApjbqKVuh7vpU8xpPQ696FsTuMm4DTXf27favBOIvCcWxU9goPCyxo6JWo0NaWqowv
         S03NhAPnsNOLqNh7k0/btnzvHZnfwjyrZkageBEbCStiDqL04zffqKz+d88tHdg73ynC
         EmBrfGU0mJb78RTlmkfcIvgrIosy0T1SdeuCgCeZ7g/kEdxriWQ661Kb9y3f3a1eIo9y
         dq1A==
X-Gm-Message-State: APjAAAX42AcCGIrY2TVnlxnXLGMgSY8RWAHc4B341XL6NJGgEQlmXd8s
        KpL8fDdrwOHc21MUYQ4Sx2ytQeF8LunmXw==
X-Google-Smtp-Source: APXvYqxNCiYkAn2dzeFZSXPG5DMbIRBjoB9Lm0/Nf34i1wHePgGQ+VKpf7x4sUOuxIeJQj6D3DZVgQ==
X-Received: by 2002:a05:620a:10a7:: with SMTP id h7mr54299099qkk.423.1577722625559;
        Mon, 30 Dec 2019 08:17:05 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::2e4b])
        by smtp.gmail.com with ESMTPSA id v4sm13857315qtd.24.2019.12.30.08.17.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2019 08:17:04 -0800 (PST)
Subject: Re: [PATCH RFC 2/3] btrfs: Update per-profile available space when
 device size/used space get updated
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20191225133938.115733-1-wqu@suse.com>
 <20191225133938.115733-3-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <21f4fadd-f081-6acc-1f79-ca52b68607ec@toxicpanda.com>
Date:   Mon, 30 Dec 2019 11:17:03 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191225133938.115733-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/25/19 8:39 AM, Qu Wenruo wrote:
> There are 4 locations where device size or used space get updated:
> - Chunk allocation
> - Chunk removal
> - Device grow
> - Device shrink
> 
> Now also update per-profile available space at those timings.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Looks like you are missing chunk allocation?  Thanks,

Josef
