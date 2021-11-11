Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B2244CE30
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Nov 2021 01:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhKKAVZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 19:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbhKKAVY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 19:21:24 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD5DC061766
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 16:18:36 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id bi29so4240108qkb.5
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 16:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=lMMNjXeBLUHfydbC71U0s/LbHbR3hby+z0nKParsX0o=;
        b=oH4zB/lwZkbyo6GhDj6QgSPMa8bdpsIG2e9UsxES6bL/7WsQ1eOU2vdT9NCscVvvrJ
         Ruir7pkRqlv1Eg+JGoV6I9XcG5sXrPVhZKuSAmKUFEhgvK5a51U8aDdw0BdOcch8Rj7I
         zR+kMnGeEp9tvKQuHOREhKI7KpxL8pn6QhIkGZ532bJbMm7jHARtCvuh9xjhPRSi3nRg
         4L8s7IFz/t4dmCzwZDaDaKZh4HJdkNWynMy8Gw6wcMB0hQOYyLdt4Erg4omgXEDg05o6
         KFBkc78vf9Mg9jqqmtG02rwOJNCMdLZwymRjo3vkLoQGBGPr0trzof5Qc4LQb+zzzzZS
         ekIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lMMNjXeBLUHfydbC71U0s/LbHbR3hby+z0nKParsX0o=;
        b=rZfQNeZHZ6gzdp1KE0FWY3nuKfqYuEHOR7p0OPwwLkomFXDiHVdUPfmuX+9wABhcR3
         GZgp+LjSCLoCqZoz34eWoQaVx4wjMoIIEa/TGwc7RkMjlyz1duxdCYIz30QdVImMvMex
         08khZxQkXMYBEs7VCpqbEIixNaz+yMeOYzmDlqBZhn++NDA78teN7/TmZDKpm21J+9K6
         LPRYbCibKNj0yvjnOtjr/7SFuXhwrlk9K8AWY8bd5u+Q2WupbaH+1V33fwPX9P9qgSO3
         Ooh7Fwm8wOIk1Jc/BhjD4Y9qxwONs1HlMyHFQw+UtNsz2PDBDUKnbfrF3wx1yWKYVWie
         SiyQ==
X-Gm-Message-State: AOAM530Fb6UqJ2U61mL3HNwc2E09B+K2mXogsTKwoal1JLLY3idBuMEk
        1xeBryo5ex3L5ImQKnIlRkE=
X-Google-Smtp-Source: ABdhPJzE6b9QQNdt/Q8SHEDv9fJ6/j+VgZxJ4Xf1ZUW1v3Xgspr2e3VX5/vlizpPWGUBqytUoWFMTw==
X-Received: by 2002:a37:dd4:: with SMTP id 203mr2784624qkn.149.1636589915405;
        Wed, 10 Nov 2021 16:18:35 -0800 (PST)
Received: from ?IPV6:2800:370:144:81b0:f245:e007:48ea:38b5? ([2800:370:144:81b0:f245:e007:48ea:38b5])
        by smtp.gmail.com with ESMTPSA id bs34sm656300qkb.97.2021.11.10.16.18.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 16:18:34 -0800 (PST)
Message-ID: <4f7be37a-502c-6ee1-2519-29b84810999c@gmail.com>
Date:   Wed, 10 Nov 2021 19:18:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:88.0) Gecko/20100101
 Firefox/88.0
Subject: Re: Upgraded from Buster to Bullseye, unmountable Btrfs filesystem
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <a979e8db-f86a-dd3a-6f0a-588b14bbd97f@gmail.com>
 <37379516-cc7c-b045-ad2e-15c669a60921@gmail.com>
 <179e61f7-82c9-0a5f-1a05-7c0019b4f126@gmail.com>
 <76156d73-9d4c-a473-4dd2-105a905d3d1e@gmx.com>
 <c94ecfa2-752b-9952-9483-ae3dd04f6c02@gmail.com>
 <1f4db1f5-2f37-0074-cbe8-e78ba7836587@gmx.com>
From:   "S." <sb56637@gmail.com>
In-Reply-To: <1f4db1f5-2f37-0074-cbe8-e78ba7836587@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/10/21 18:46, Qu Wenruo wrote:
> So it means, we still need btrfs-progs to repair it.
> 
> Thus I believe you still need to prepare a build environment for it.
> 
> For the worst case, I could try to build a static btrfs-progs for you if
> you could provide the "uname -a" output.

Thanks for your time and patience. If you have time for a static build of btrfs-progs I would be very grateful.
# uname -a
Linux OpenMediaVault 5.10.0-9-marvell #1 Debian 5.10.70-1 (2021-09-30) armv5tel GNU/Linux
