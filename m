Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B761A3D1842
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jul 2021 22:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhGUUAV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jul 2021 16:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhGUUAV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jul 2021 16:00:21 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A681CC061575
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jul 2021 13:40:57 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id i4so1588906qvq.10
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jul 2021 13:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=t+TMxxnGRy84Zh6fBJxce4cgNkD9Onu7Q7a5TfijRqA=;
        b=V6w1gIabSB7XFswKmdjGz7PshFPB3auh8zLHS83lnpgAb/3+QJ1cMM1rxelRKGkIGG
         F6G45ceuUnDUU1W3mGiPKy7qgmUEplHs9PvU5fx20DbnDxdxsJzhbKg/hs8ej9ix873p
         jIeuwgh18c+iEpB+q96DKt8uKkgHDjKsUGJBD9lzYxzH0WA5P5/45qr6CvF8wTdUiqdZ
         SarAMK9nwb8GmEouKWIE5fSSfJMcG5MaktO9PtCF64rWGrmIENBggbWb64+IVoA4AXb+
         7kEHEdB+ASidFcUSJkANlBw3fTSUqZ9RKdbHiAGkcZW5EPbEmEQMP/2e7LCp9cQ1O/VW
         i1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t+TMxxnGRy84Zh6fBJxce4cgNkD9Onu7Q7a5TfijRqA=;
        b=Np/S69hiIILRndxbfzVXxVzG9uFrPF2dSnhfRYSWmi9l0f7OgVR8SOE4Q5Me5T/SeN
         W5RJrh9kn2ZrN5venrcrqhN0WHbgSO83TZ2NDG/Jonvf3BS24ZLn4HM11NNdpPl4rw6o
         jtmHOQy39waWnc4OFqzUrjU+Zy1OUiu9rVJ8BpJWEHcazySJ8WTTK8UKgMGouKhku54v
         O+WeIEmMAispcdTl6MHiBMwGWPD+R8Rh8pfFfZqaKTF6JccpuNIeTXvGl9EI2lIknd/H
         L1NNrmMM30Yu3S7gGdUUXi+LJhxFpbrMmLG891TrrXGezBRPk/x7hxVP+ajayQoUDH39
         efTg==
X-Gm-Message-State: AOAM533JgyovPvE/550uV3itRj6/ofxL0FXk+7iEzbgUkOgf4V6JKi2L
        xbAPnyketRhKJs8p4d4d5djF10sW96qkty9Y
X-Google-Smtp-Source: ABdhPJyCJHpcdyEaMWWz3hdc3DR5AzoMJ3XovuMk6gMs/dsgepBfOQCnkuyt4fSpogigucNEcaZR9g==
X-Received: by 2002:a05:6214:5b0:: with SMTP id by16mr37103075qvb.54.1626900056424;
        Wed, 21 Jul 2021 13:40:56 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11e8::1223? ([2620:10d:c091:480::1:9441])
        by smtp.gmail.com with ESMTPSA id g76sm11699665qke.127.2021.07.21.13.40.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 13:40:55 -0700 (PDT)
Subject: Re: [PATCH 0/2] btrfs: make the batch insertion of dir index keys
 more efficient
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1626791739.git.fdmanana@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <868e88cd-cad9-ffa5-de71-2fc2838d191f@toxicpanda.com>
Date:   Wed, 21 Jul 2021 16:40:54 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <cover.1626791739.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/20/21 11:05 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The first patch makes the batch insertion of dir index keys (delayed items)
> more efficient. The second patch is a cleanup, but only applies cleanly after
> the first patch.
> 
> Filipe Manana (2):
>    btrfs: improve the batch insertion of delayed items
>    btrfs: stop doing GFP_KERNEL memory allocations in the ref verify tool
> 

You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to the series, thanks,

Josef
