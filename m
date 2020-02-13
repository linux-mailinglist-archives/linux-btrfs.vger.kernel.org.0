Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 856AB15CBAF
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 21:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbgBMUIX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 15:08:23 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43490 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbgBMUIW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 15:08:22 -0500
Received: by mail-pg1-f194.google.com with SMTP id u12so3333920pgb.10
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2020 12:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=szZEJ1ZQvXheE8HUYVyJUrfj5vVZ4f3I1gMhdrFgMmU=;
        b=HSw8aSWtWxWSfiKG9mzHcseVxGUvHJabf81U1Z69PjBFo0yKGcROoG1EvQSHe/sjBP
         quPz9827JVG+N07fcUuEiWsfVAyhvwMlOsjDbYCaOQo5llTOxNDbxNJLw2ed5JeS+UOv
         1Ew/wCbyODzxwy9Ijl0t5YWlBX0dY6iI5eUW97YnZjVZUm25+KivTmlAsZ8NCldrleA4
         cWZUchuTJNrq9j/NlZP5e4IWMJQCX3LIHC7VLGh/QTMJeOzq0Ow5mJS+ZCbJpv1DGg00
         DlIiO1K1DmJ76l0hTV55IV231k9UztFvEdisbIEM7URS7XEhBENcw/VTcHDPoe9/JXcG
         NOhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=szZEJ1ZQvXheE8HUYVyJUrfj5vVZ4f3I1gMhdrFgMmU=;
        b=bYOsv+kn1oM4Hk2+2R4DprJXasCLdy0DSnMNrZ+t9Phq0W/Tu9SASfqWMJBCeTKdD/
         VXHd15DE3a+uBoAMl6lkzm4cGCNeSogbOL/UgaDIw5j2ltAe8NRS2dkz+voXZKocjT6Y
         WGEpmw7LRPPWBix+jfhCCjSTrhAosKXbuf63XIaxEq3gir+B0Lp/YtztQKchLORQDUmx
         eRPHozVJoP+E9fxTWYFst3KnsGPyIOF4NsDUxyY+wDraU1og2O/PEDaSyWCBJyMc6lmn
         zixlSbJqD9mijvuM7JaKsOinovjObr9f/F9Sh/6H1DlO2HQjq65Btar+H8WVeIC0jTeO
         DtHA==
X-Gm-Message-State: APjAAAXF+yaoYnnn+xJzP4Rw0xyeYwSOJivMzZNwAAcsW9YbdKPGL6Sf
        m5Rgf7DkULxR7Iu0dcU/x16pYbFUXvA=
X-Google-Smtp-Source: APXvYqzDOAF6WeRXyfwVdL5yCIwNbIAEnjtyHpAoQtj/mE9sdCnFEOl+td2ZJ7+w6a4S7bTJDyQDyQ==
X-Received: by 2002:a62:1a97:: with SMTP id a145mr19533871pfa.244.1581624501676;
        Thu, 13 Feb 2020 12:08:21 -0800 (PST)
Received: from ?IPv6:2620:10d:c085:21cf::1150? ([2620:10d:c090:400::5:249c])
        by smtp.gmail.com with ESMTPSA id i190sm4167986pgd.75.2020.02.13.12.08.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 12:08:20 -0800 (PST)
Subject: Re: [PATCH v2 4/4] btrfs: relocation: Work around dead relocation
 stage loop
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200211053729.20807-1-wqu@suse.com>
 <20200211053729.20807-5-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <75628279-595e-2ab7-b808-18ce0251f5b0@toxicpanda.com>
Date:   Thu, 13 Feb 2020 15:08:18 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200211053729.20807-5-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/11/20 12:37 AM, Qu Wenruo wrote:
> There are some reports of dead relocation stage loop, where dmesg is
> flooded by "Found X extents".
> 
> The root cause of it is still uncertain, but we can work around such bug
> by checking cancelling request so user can at least cancel such dead
> loop.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---

Why?  It'll get picked up by one of the other cancel checks right?  I'd rather 
know why things are going wrong than put something in for a just in case 
scenario, especially since the other cancel points actually make sense and will 
accomplish the same goal.  Thanks,

Josef
