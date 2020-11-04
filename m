Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80392A6F33
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Nov 2020 21:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731544AbgKDUwc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Nov 2020 15:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbgKDUwc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Nov 2020 15:52:32 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7815C0613D3
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Nov 2020 12:52:30 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id h12so19089qtu.1
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Nov 2020 12:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=H7Xdu7oUYIkDRt54+K54mCiCzJz5+eJ3avaC06grFZQ=;
        b=wYGZkAVO3dmeH/AOyd2N8TVe0LE/uIu04D8Y+UugOuOpcxKvjCDXlEz6ay8LdrySH4
         i3d6h96ZNG6HxcYp9E+cmYwVZ9CdBAYMB19aJc1v1zZ1tugXLfqvrm4nxnhra7XxeR8z
         9Os8seUS3Lg2dDk3JyEDAGWAaIPibN1vdxTyNIBZkscOpgsVqjJjygdy4G+/NIj4XQdO
         IJuiiwiJXVbyCBMM8LuvrzkWTx0grLtSzZ2aXLBvHznkE3Eb1bp9XB4Tp+RbOiOeABG5
         vAHJ9lkMGX3H97TrNlh0D7JipsGrlnyCkmGMHIStdtw9PembS8FalezsH9lGmLyEN0Kr
         QTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H7Xdu7oUYIkDRt54+K54mCiCzJz5+eJ3avaC06grFZQ=;
        b=RFf5CE4B9EJmmX+6OcasgSIEPNDKX1Yfl4u7maitzJd8Vo8EMrI8X3UXTtbokTlyL1
         +jR9OIf/ApvQ6wHJTy+uUzjB3FBfKY53b0QCS4J10uXyM2rC03AgvVrrMmLCsZ9udSIz
         +nKwvGbF+J944ErbDPmDoVKHuzqNvHyF2mxPRKyuy4mE3U5YcdPga2EWzF8FpvV6Apds
         Uv2pOedNSoHcFw6WDIaXsCGMO2XR2XPqQDtow/C1rWMVbWiQqJDzrzMmf25E8/DhXscx
         pB9GBvOH2JgTeWbilSxzSo6O6KhOsqTkONxzpatmX31wQm9QvhxdOjT2ovowsinzTfpC
         Pf7w==
X-Gm-Message-State: AOAM532Anf8yqjSFzAPHvgDgh+IBoQcsuuwWoqxexg/GOJPPvR2Lj+mZ
        tyQ2R3sMKeb2/KOQurtrAJv039gpGCWmfw==
X-Google-Smtp-Source: ABdhPJyzlf/sMnNSG4Gg+v97ayBF6XF8x65h17XnMq7+/RD4ysgkrfiV67RgfHjxUlkNq7PQ5BhDnw==
X-Received: by 2002:ac8:7684:: with SMTP id g4mr10157098qtr.64.1604523149816;
        Wed, 04 Nov 2020 12:52:29 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:11c1::1180? ([2620:10d:c091:480::1:8f29])
        by smtp.gmail.com with ESMTPSA id b8sm3413989qkn.133.2020.11.04.12.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 12:52:29 -0800 (PST)
Subject: Re: [PATCH 1/4] btrfs: discard: speed up discard up to iops_limit
To:     Pavel Begunkov <asml.silence@gmail.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1604444952.git.asml.silence@gmail.com>
 <2a3d84dfc9384eed8659963d1dafedabb3f17c75.1604444952.git.asml.silence@gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <7452d21a-a2de-618d-ad9d-7a2223debd5e@toxicpanda.com>
Date:   Wed, 4 Nov 2020 15:52:27 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <2a3d84dfc9384eed8659963d1dafedabb3f17c75.1604444952.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/4/20 4:45 AM, Pavel Begunkov wrote:
> Instead of using iops_limit only for cutting off extremes, calculate the
> discard delay directly from it, so it closely follows iops_limit and
> doesn't under-discarding even though quotas are not saturated.
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
