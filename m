Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFF618201B
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Mar 2020 18:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbgCKR5T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Mar 2020 13:57:19 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38868 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730450AbgCKR5S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Mar 2020 13:57:18 -0400
Received: by mail-qt1-f195.google.com with SMTP id e20so2249429qto.5
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Mar 2020 10:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xk0IJXBn/IsshWJz3x0G6KJz8fgzKwEReL0n/l/sej0=;
        b=EBnFpseU3NujrTTuKuqL8A1bXQTrgZe5yvRngBo8vZdzMQCDvkmvw5G4vrV5xlE4kk
         4EiS0qpFmVT0AlLZaPKVj+CAUobeUs+fjf0wGwesrl76UJmyztJ3xwSVc7FAucItkh8t
         2nbxtFUVSVS0NYoQlXxMSoAYaFpRZzy+QYjtsV3c70JEoGIg0BBT5k3twXyVGUaC/uzV
         gWTsA0WBRZz9VOnexefjZaYTbj9eYQb8r9brbIb8itXJ0gL/Ku/rVIm6odnSAsVHw3Me
         svvIF/7yoKAhAVJC3ygoM0u1xtOPFWas4deBYbWF+5fOtwgZsAG80leh+IV21ioNJ96F
         f/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xk0IJXBn/IsshWJz3x0G6KJz8fgzKwEReL0n/l/sej0=;
        b=MyTienKeT2W3z+GnMWo9jGYBxDrtxv4huSVRgDXvpV7bo3Rc3pOQDaNEpFb77DKCnn
         cfaz4bNdtcnSjo2cPSmalXkB7c3bCCeBm00wYxX+X/KV5pEwflIeibfli4lm1S5el+5A
         k2OsgufCGBDH56WhlwQE0ujquE4soG4KQEZUUTgVHkwGacB4v84EOE2sewmjwSSvbfsV
         HtrSJDNZz+R6BkegXNLnwIYS8vCp3gkDn5BTI1K0HDmx/wKruXad7z7K/s8VxouHbvB1
         hgkBqKnIotcboTvXYUD0onXL3k5zA5O8t8Xo58M3sro6xAt1CFkMFz/WNnyBYzc5hbXr
         p1qg==
X-Gm-Message-State: ANhLgQ18BK7e59F6osqckKgBUqbJWYPrd7LXyl69m7YHkgDt3cCNnDXR
        o2ydEKOz9YAWNLBgKv00o3hTag==
X-Google-Smtp-Source: ADFU+vvAqb0mWKrkr4AjEisK2xWSdcnnP2bhLIs7ydY7jktj+wDReL7gcV8G9jBJ519QEZsqM2fZLg==
X-Received: by 2002:ac8:708f:: with SMTP id y15mr3193041qto.35.1583949435947;
        Wed, 11 Mar 2020 10:57:15 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id p191sm9219698qke.6.2020.03.11.10.57.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 10:57:15 -0700 (PDT)
Subject: Re: [PATCH 06/15] btrfs: rename __readpage_endio_check to
 check_data_csum
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Christoph Hellwig <hch@lst.de>
References: <cover.1583789410.git.osandov@fb.com>
 <f0404525ae352a08750f56a822512a52263d7277.1583789410.git.osandov@fb.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <57582c0f-934d-2b58-8c4e-aa6bde3f795b@toxicpanda.com>
Date:   Wed, 11 Mar 2020 13:57:14 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <f0404525ae352a08750f56a822512a52263d7277.1583789410.git.osandov@fb.com>
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
> __readpage_endio_check() is also used from the direct I/O read code, so
> give it a more descriptive name.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
