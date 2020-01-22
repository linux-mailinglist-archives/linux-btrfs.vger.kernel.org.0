Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDECC145CEF
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2020 21:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgAVUOa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jan 2020 15:14:30 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41595 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgAVUO3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jan 2020 15:14:29 -0500
Received: by mail-qk1-f196.google.com with SMTP id p5so1031671qki.8
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jan 2020 12:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=WWoBvIg7y12gr7dMagw1KBCprJN2oOpX0w7CwLt72pY=;
        b=Mo18v0cP0Q78pw/Hqix193WGDqC4zCE3mVpmPQN1VFB7YwSAkrMryLg1N+VPe9Jnot
         xnQkaEpRdbTBHBu4wfNPvcHujs/pJEvFW5x64+rk3REhACstR7Y+bExmislW0k9ahhWV
         +l6xeQA5dP+JjQet8aZcCaCLd4rUtSFeOCN6ZOthAvmYMGcWSjJcZ0jXlP0TEinCBt3H
         CSqj5jvALwKet6zSIyWzsyvmpCvCcLUxZnjQxKia82iedjqwD96nd6y7CC4tqbb4RpT2
         0MkTlKds7ar9B2x/QkvbWjMzFT9eeuapP0Tm5+QQmQr4OFCyX1Txb7EQ2M1r3UJAlL+N
         9aXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WWoBvIg7y12gr7dMagw1KBCprJN2oOpX0w7CwLt72pY=;
        b=ZNDuce52vJeCXjtORzucCahbG46Rw76w+O2S7+yb/FC67Kiy9jEul2pA5jmoqehdff
         AtgDp2GgcWrTUif+DQA5v+CVcooEcBZ/VhpeiKOD0682LTs78NKaI9JrApBpy+h+xRAV
         l+fNY+Nqxv7d5eMDyQS+SQMwjIUaBz7SGTOaPDdIgYyLX1Z2SPe1tOopH7M0OM6aiL0P
         DpaKl7Ja0zfqDnugX9zxcwuBVp959hHRD8fxuA7PlvmAqVf3+g8+sG4i3/u1WRY7vwyA
         uNPwzrIvKJtMDmsSS7nDZ/Wxl4hpRUtM0hG/CkVdAaD8AldHVZZZ8zBWNfKH+6k45p1+
         dg4Q==
X-Gm-Message-State: APjAAAXFW+rt+0POj04VOADn/0S6dpt7uzW8mrgNFKpBnns8/r0YwbRd
        jnUVTRZWZvA0mJP3FLN0NV8j+0bG7MGurg==
X-Google-Smtp-Source: APXvYqw7rfHB5HvhCOc5EHP47j9CF7adZJCVy34MgUn1oB+eY197Z4H4MDq25+HEXvhRCSFV6apMpg==
X-Received: by 2002:a05:620a:1014:: with SMTP id z20mr11892023qkj.196.1579724068163;
        Wed, 22 Jan 2020 12:14:28 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::7e55])
        by smtp.gmail.com with ESMTPSA id h13sm2297406qtu.23.2020.01.22.12.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 12:14:27 -0800 (PST)
Subject: Re: [PATCH 10/11] btrfs: Factor out pinned extent clean up in
 btrfs_delete_unused_bgs
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200120140918.15647-1-nborisov@suse.com>
 <20200120140918.15647-11-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <4d89ffad-86ed-6d10-9bdf-093724897ddb@toxicpanda.com>
Date:   Wed, 22 Jan 2020 15:14:16 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200120140918.15647-11-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/20/20 9:09 AM, Nikolay Borisov wrote:
> Next patch is going to refactor how pinned extents are tracked which
> will necessitate changing this code. To ease that work and contain the
> changes factor the code now in preparation, this will also help review.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
