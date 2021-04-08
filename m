Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F3B358C08
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Apr 2021 20:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbhDHSSH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Apr 2021 14:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbhDHSSG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Apr 2021 14:18:06 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D252C061760
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Apr 2021 11:17:55 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id q3so3159935qkq.12
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Apr 2021 11:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=kSbOCVHBjFkGJnlYDrMVgW5BOwLYRgHhF/rOLWcV3bk=;
        b=JbtmX42Sc/6FA0fEukohass3g7WlTPIWjXnOoVLykXskMMpSKUxI1bUt0Wlr5N6TNk
         qZex+Hyxyp71sb99ahwPGDC5oNmnzpTM7QqFz0hZots/u2W2uHZhMlOn90vXT6Vi3rWe
         eRo56q8uO5Lu5NuTFSnXGkD3WSOJtbDw4WYunL7sJaH51UQmEwDjLCpNd/JI1txOWhfq
         jc2xBeCN2fzzyvZV+SqaCoPba0X+J6xZpsp6tpSVxPbjAXz8FI1BHg0E+F9ak7hEoHAJ
         I4iWMkPTmxml+j5iy70gsNux1RW6wjDkLXJ1pk+rA26dfSDMaO8a6QO6q/fYxPMPn/Sq
         VR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kSbOCVHBjFkGJnlYDrMVgW5BOwLYRgHhF/rOLWcV3bk=;
        b=kyP3YwHvFErCTaDVixF/DnaRLfWS+xxiDdO2vBGqQVroz992W0K1bCJpNo6XaOJ1sF
         72tnp+egKB9NDZ5jgde0ZX7agR6tCDUBS/UZoE9neS9pqMAHJI0KRaFTiirJqI6ysnzM
         kk+x7JvHTrHCD+eLdawmmeawJh2yIpN0Ri9P5ypsmPKqfv4HuGLNX8Vh9WUeXJISVpbX
         282m0HTW1+VutDHMWuOinrlp1ydWd8E2HQMS3CJPi31ErJDYItTBjErgpPwRTmxUIncC
         0OvEH1WRny7Q7cteO7t3ah2W3wYFQKoVpMdpC3FaM8ysW0NZOW0TG9jVkWpKLQi4aUej
         nD5g==
X-Gm-Message-State: AOAM5320i9osZm70NaGyh2kE6242XraoWsoKxdiyYTZwa7YyDjc+cJSC
        OZVEpeXy4dkuuGMjhJEhwE5g0MfAlCYLVg==
X-Google-Smtp-Source: ABdhPJxz6HG3Y9qgQvIt2fyNlXuZXoKPDRkmNmBeLdsXpWjq+quAfFKlzS9Fi1HBiIYS/fwZcpYKGQ==
X-Received: by 2002:a37:6115:: with SMTP id v21mr10011155qkb.239.1617905874181;
        Thu, 08 Apr 2021 11:17:54 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11c1::11cc? ([2620:10d:c091:480::1:a6d7])
        by smtp.gmail.com with ESMTPSA id v7sm42516qkv.86.2021.04.08.11.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 11:17:53 -0700 (PDT)
Subject: Re: [PATCH] btrfs-progs: Fix null pointer deref in balance_level
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20210406135503.164590-1-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <ec3638ee-9ae9-ad82-6faa-5a2eea9df2f9@toxicpanda.com>
Date:   Thu, 8 Apr 2021 14:17:52 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210406135503.164590-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/6/21 9:55 AM, Nikolay Borisov wrote:
> In case the right buffer is emptied it's first set to null and
> subsequently it's dereferenced to get its size to pass to root_sub_used.
> This naturally leads to a null pointer dereference. The correct thing
> to do is to pass the stashed right->len in "blocksize".
> 
> Fixes #296
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
