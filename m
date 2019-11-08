Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11BC9F5798
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2019 21:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730810AbfKHT2S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Nov 2019 14:28:18 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39076 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730379AbfKHT2R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Nov 2019 14:28:17 -0500
Received: by mail-qt1-f193.google.com with SMTP id t8so7738238qtc.6
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Nov 2019 11:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Sr1HKdCi1ViJS86soYCLUYfdZdhiuE47mnJtkc5LP7M=;
        b=aZA/Q9IK1b4tOw4xxZR6vVwoMmEr570Wgv/mBKcHT/wxArZCxpbOuaGcWrNuLbZwwI
         uVLGO5mAkEAwIPzkbIBiZlwN3xswiNajTXyCiL0ANyEsJvkE/J5b7PmjAiSSdUmaU/DT
         x6cdXPtYex/wzvD2s1a+VdvlB/lIjONBRkg/gMffL++CcV8+UgZdo/2ehZLIziYODmhw
         +DKAZWW0DxFajXfHlEEa91mNaLhs19y7GJp+mPri28I7iPjQ0g+6gx5b+9TXHQZ1IIO6
         FvIAj6Wfi3cDQaq+E3i6q52D8wTqV50umIQA1e7fe9FMa1OoALx4MwY0ZrEFy2Sw6iOp
         Tl1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Sr1HKdCi1ViJS86soYCLUYfdZdhiuE47mnJtkc5LP7M=;
        b=qD0fnQFjOhcxiWvrDOTAbSvsXHAd5IfhvFlEdmOlEYFzndc8CqzZaO5CK7MS7kfOfz
         rFVszs+sRaAUu4QBSGVG89HLq4hcRu4G1Yr7IN+Mj9A1z7/3uMjB59ubTqkivn508SLU
         E/HmNe6K750w8OLE8PTKNSgUe1MJg9hPEDkm3NhVtkc1Ti/Umn3yqbvvEmlEcq4M8bBk
         g97TGMX+LEuLuvHs8H0wOmFbIE+sGX9CP7Cpe+yPoAmnOCNN6IJzF3/BynqC/mmY0d46
         tQMc4lFRlgHwy0/XB678Oawr5MP92zErx78tRR2ZG8w8zQIuHHDWzUeQ86RIhU5tz/kx
         rjfw==
X-Gm-Message-State: APjAAAV0xRj2SIXnYRIyczRzNHtZoY6Ue7YYLR7JMsVCW6+7s7rEkIum
        7+m8yrbNjqorDTAQYWu9LVQfeQ==
X-Google-Smtp-Source: APXvYqyiTQxLDHqwLxEY6n/aXSU+Kazp2RpfrvYy3vDr36pyloZJ/VJ/ILRqq85Vd5ypg3dk4X2hxQ==
X-Received: by 2002:ac8:ecc:: with SMTP id w12mr12542998qti.134.1573241295474;
        Fri, 08 Nov 2019 11:28:15 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1852])
        by smtp.gmail.com with ESMTPSA id l124sm3524299qkf.122.2019.11.08.11.28.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 11:28:14 -0800 (PST)
Date:   Fri, 8 Nov 2019 14:28:13 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 08/22] btrfs: add removal calls for sysfs debug/
Message-ID: <20191108192812.watrenb4aolykr6a@macbook-pro-91.dhcp.thefacebook.com>
References: <cover.1571865774.git.dennis@kernel.org>
 <a30746a1a3db0798aec558d9badbaf4f19320869.1571865774.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a30746a1a3db0798aec558d9badbaf4f19320869.1571865774.git.dennis@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 23, 2019 at 06:53:02PM -0400, Dennis Zhou wrote:
> We probably should call sysfs_remove_group() on debug/.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
