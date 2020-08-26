Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E02253172
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Aug 2020 16:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgHZOgR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Aug 2020 10:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbgHZOfG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Aug 2020 10:35:06 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514C1C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Aug 2020 07:35:06 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id o12so1983449qki.13
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Aug 2020 07:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=mehKiKbSuu8JQZgRDG15+pQvs2KleqjlA8Y82Na1v3k=;
        b=JMmKYWLiqW1M97vY2TqG6oH3u4HaBjDDQplzK5YiVq0oOw44QJXBW8Z8OhNGfS6Ppp
         25JmpDUYZcnCaM5fcIfF1eI4ffPNc++DZVideHfuhIuGd+IjB7JvcDlSHt4FkS6OUkXo
         JFMs2y1NlOiLKOL2nzTX5gYLM4/Z71AydvKn3GH9/W48SHb2LH+FZHjE1ov3y4psHXwD
         k2AtuLXXYLWN63Y+D7DG5MHWd16PTy0cNGW/NCHs5q/YxwGZFag2yU8xTfdKkBIyKWf4
         KonM7fQvUQ664YFrdn9T1s6s279zKGJeEaKKDNcbqYaVD4YqVtSuOnznswb7DnG9L0LA
         S77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mehKiKbSuu8JQZgRDG15+pQvs2KleqjlA8Y82Na1v3k=;
        b=g+njXe09mptH/rTWq1/iIqy5LpXg+f209Be8/B+WyLXVr4mrYzFEv0XsjYJRMOwQhC
         N3Yip+M+SD8T29XfGaWU2+IyHoZcyDOBsBM+pghQHjsc3lt9JcOKvYUoPmk62CceGbYZ
         S2MLIEaU5/FltvZB3eGKDOp4yUkY4E7kLN5Hs0l3szIHERfKasZ1AHQx7bp7Ia1cQ++R
         eW/vx5xOQMUor+xagB92EXaqZBw3hrhSuPlneh7UaF4oQTrTmuB37+XSvt7mAj9/lrr3
         evIoAHIskjBcw6ZiTFnNgaZqg9ASRiQ1T76T6j0HEQ77H/7O2eCnjZOhhQOwTlRfAtIf
         lwWQ==
X-Gm-Message-State: AOAM533J3kKbgoX5w8K+YtvHLWeRkDmRTleoHTIqCDqQfAQX+5V5gNjh
        Ncx+6BfF2bU7PxTwp9K4y6yCWYJrf6pT3orx
X-Google-Smtp-Source: ABdhPJwGGLkN7hkDJc/O/80Td6CJaKsQxkijYZCHT2g3Bl9IRnuW7gDv5UpraWjVPsdxiCw0iYT1Pg==
X-Received: by 2002:a37:8405:: with SMTP id g5mr13994760qkd.286.1598452504956;
        Wed, 26 Aug 2020 07:35:04 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d9::10f3? ([2620:10d:c091:480::1:efc3])
        by smtp.gmail.com with ESMTPSA id i6sm1744715qke.7.2020.08.26.07.35.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 07:35:04 -0700 (PDT)
Subject: Re: [PATCH 2/3] btrfs-progs: check/original: add inode transid detect
 and repair support
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200826005233.90063-1-wqu@suse.com>
 <20200826005233.90063-3-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <36d2d38a-9878-8964-2207-91a2a98c8884@toxicpanda.com>
Date:   Wed, 26 Aug 2020 10:35:03 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200826005233.90063-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/25/20 8:52 PM, Qu Wenruo wrote:
> The inode transid detect and repair is reusing the existing inode
> geneartion code.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

