Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67CF112E897
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 17:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbgABQRe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 11:17:34 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39191 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgABQRd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jan 2020 11:17:33 -0500
Received: by mail-qk1-f196.google.com with SMTP id c16so31714240qko.6
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jan 2020 08:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Ek0d9NSgVIcmxPAmOPKS9s9dXdzhAA4rIpIbi8+9b6g=;
        b=cYkVRCwl6YnGapBdicbEklQ4QO5+/6KSqFSrJ+n30qXUoMWcK/61QR188leotyvzMu
         0xR8axexcVqE2j2T/lW3b09iPDBXjKFmS8erOVFz4KqcG8qpQJzk6SegRxrPmcU6FdBD
         PnviJt9YKZQ+/dPUJm8eKG5TITyIn8ja1EPpf2NGsSqfDRfn8/xVBs2alz5bNjfLSCwj
         zqhDBoUfy5uZ49i0Wcz388ki69qqlKcBlfpYBYJ3ghpF2BOoYc7Q4td8zqKoqUM/7CBR
         22QcxS08PDiBCu/WsT76VliKhXkQ++LluVYYFvlaId8VizXRlD3d7j9zN50S21YuTL+6
         CpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ek0d9NSgVIcmxPAmOPKS9s9dXdzhAA4rIpIbi8+9b6g=;
        b=sqBIsDKJiE5OTZD57BzO1WfDdYgWAHI3Bcs9i8cWcJU+WwsjQFontOqlEt+tPzGrsS
         fXbpP1Yj1vX8il222IjyoV94TX4mTG3reSA+SmZtBFnLQLXxkjq4zHuCbKwg6ob38jIh
         6eg13HTvc8GwdWV2xB+TuOQ3mhIAC3iKF0z1CUH9ttNjcoIGqaR5u/WcjRjoyaHDI1VI
         z8+KsNQk6pxkp0hLXl0tMm7pdzlubh8h7+4AAcC92V1CHHcrcrDe3zc3gpm7z1yN4se4
         XoEZFgDdGCVsl00kPgxfTqPZXSbnZJQNqHECs0DLTInrodBJAFWLyXdctIxKNRIL2wCH
         e89A==
X-Gm-Message-State: APjAAAU9pfMMz4u6ATDWYGAePSToEwoigr2yjOnAXFMmOaYCHfkOAOYi
        xqUZjz9xBFIKUHTKzm0y4bnicdLTe6SUnA==
X-Google-Smtp-Source: APXvYqyPvU5s9REfE321P7Fp7iZwdZNfYyVW3AXj76U+dL6CLLut+63XCeRgaZKIvAF9fjlhtK/mcw==
X-Received: by 2002:a37:4f8e:: with SMTP id d136mr67020134qkb.495.1577981852622;
        Thu, 02 Jan 2020 08:17:32 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::be95])
        by smtp.gmail.com with ESMTPSA id 63sm15217838qki.57.2020.01.02.08.17.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2020 08:17:31 -0800 (PST)
Subject: Re: [PATCH v2 2/4] btrfs: Update per-profile available space when
 device size/used space get updated
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200102112746.145045-1-wqu@suse.com>
 <20200102112746.145045-3-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <c4f6ddfb-c52c-d376-4cef-26aebec4e288@toxicpanda.com>
Date:   Thu, 2 Jan 2020 11:17:31 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200102112746.145045-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/2/20 6:27 AM, Qu Wenruo wrote:
> There are 4 locations where device size or used space get updated:
> - Chunk allocation
> - Chunk removal
> - Device grow
> - Device shrink
> 
> Now also update per-profile available space at those timings.
> 
> For __btrfs_alloc_chunk() we can't acquire device_list_mutex as in
> btrfs_finish_chunk_alloc() we could hold device_list_mutex and cause
> dead lock.
> 

These are protecting two different things though, holding the chunk_mutex 
doesn't keep things from being removed from the device list.

Looking at patch 1 can't we just do the device list traversal under RCU and then 
not have to worry about the locking at all?  Thanks,

Josef
