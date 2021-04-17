Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17291362FB2
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Apr 2021 13:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236172AbhDQLvB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 17 Apr 2021 07:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235901AbhDQLvB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 17 Apr 2021 07:51:01 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C44FC061574;
        Sat, 17 Apr 2021 04:50:33 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id r7so17144565wrm.1;
        Sat, 17 Apr 2021 04:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hWQTtezj5e7iWCHlJMc/HElbpfX2XhqmE3A4fxS1/zs=;
        b=TOJN98Y5AJgvwqWBXb3oN1sktUtOgOjayiLIailIKN8OfZ01K1WDZ5IGsZHu3ewnbD
         Kv0usVyqiCN/c+rwornOm/CUkJ9/W7k6XKYKD+8PabWrZn1Pjr/VePU1tzD+aTXe9HHJ
         OSqyA55TTs44hD2HqL4h9bCpe/I0Aki80XxisRJWtBOSys/UDGa8vA+DVtn9Xv1reIrg
         dEIBVuPoo/ZV0nLbIgb57QuOtfeR6x0SEheM8944eYb+ipKKwlPDTUxLh4EQV09KFGu7
         GKdaXUHjmLtoFgSLHX83A9mcRO0oH/V7odhveorl38U9L5JqGfZXNucM0SGFhKpUKk0+
         mnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hWQTtezj5e7iWCHlJMc/HElbpfX2XhqmE3A4fxS1/zs=;
        b=a/OtErxW+ICY7KYnHmYrmttsNs771kf/GHHTciOAdgc/nNpw2ATXYb8JSgUv+Y9A4l
         kDiZW/xc/Z1PXuFAviFoZoK2Bofk2j7vOKz3f4sp1o+q5UQSKAkjArw68qykom1Q8qAt
         bD2Ovz8r4YVU/8xK8+gERg9AglF4vkxKjBT9jeuDBkqQlApKopoIb76OjncKqkDlT/9O
         4aeZZOTQYzTW5V3Sd6aD1BiGRn7Z3zy4irHKd2U+e8twewPZv7v/mXHGLiKuw9HUXRnJ
         ayUxkRfjLHok96GCnE00JVostGQZrTPJeZpi5SbrLzhmUfUulRjgvpbMwGhzggXCwE22
         fRaQ==
X-Gm-Message-State: AOAM530emJVYk6zf8IK1tKl0uQNcvkJ8sUBOD4N8IrD63OjDQeWtjzio
        moEKYwIK8ifpDD81VV3OcfQ=
X-Google-Smtp-Source: ABdhPJwiI2uq4gmoZdg/8UpZ9CopW+Q7D2WGRFhJRA9IyInoGGc9jonEe7oBzmSJJrYZaHt55uxEcA==
X-Received: by 2002:a5d:65d2:: with SMTP id e18mr4059418wrw.31.1618660232167;
        Sat, 17 Apr 2021 04:50:32 -0700 (PDT)
Received: from ard0534 ([41.62.188.221])
        by smtp.gmail.com with ESMTPSA id u4sm13790693wml.0.2021.04.17.04.50.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Apr 2021 04:50:31 -0700 (PDT)
Date:   Sat, 17 Apr 2021 12:50:28 +0100
From:   Khaled Romdhani <khaledromdhani216@gmail.com>
To:     David Sterba <dsterba@suse.cz>, clm@fb.com, josef@toxicpanda.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, khaledromdhani216@gmail.com
Subject: Re: [PATCH-next] fs/btrfs: Fix uninitialized variable
Message-ID: <20210417115028.GA21778@ard0534>
References: <20210413130604.11487-1-khaledromdhani216@gmail.com>
 <20210416173203.GE7604@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416173203.GE7604@twin.jikos.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 16, 2021 at 07:32:03PM +0200, David Sterba wrote:
> On Tue, Apr 13, 2021 at 02:06:04PM +0100, Khaled ROMDHANI wrote:
> > The variable zone is not initialized. It
> > may causes a failed assertion.
> 
> Failed assertion means the 2nd one checking that the result still fits
> to 32bit type. That would mean that none of the cases were hit, but all
> callers pass valid values.
> 
> It would be better to add a default: case to catch that explicitly,
> though hitting that is considered 'will not happen'.

Yes. I will send a V2.
