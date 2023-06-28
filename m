Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4023D7411E9
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jun 2023 15:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjF1NGd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jun 2023 09:06:33 -0400
Received: from fanzine2.igalia.com ([213.97.179.56]:47160 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjF1NGb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jun 2023 09:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=D+MR7P8bQYGCEbGsXNoDBOueLyoJeBFj8ROFxbfRDe8=; b=nkbU/S3o61J1YVXOgImw9STZkx
        5HSRTYLVRMr2d8zjTVYqynp9Kz/ckUefivTMY6X80h1nl6iKWj4PPBohWgr5zpsxawSVObhO+I3ON
        N8Q+0o3VbPX/3ev/cx6+0Clb2mltjBNYNH8XXyZ6OM0/tasryRmrsBtVkyT+qoGawGpRXaCbZZV0i
        VuHw1YyUQ7mCWsoH3Oayr2JwRbFfyHsE+Dj+8ViMdeuY6stbvFl6yB5UuGObW82UBBJAnVyKkQiTA
        0CJlrKy3fsyofVVm12wZ85v7KWxBskUQQjh0EIdnv8J4zakmIg+ASNQKMxNv+F4sBj4P7kJhx7djF
        wY8jIvxg==;
Received: from [179.232.147.2] (helo=[192.168.0.5])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qEUsO-005Fqj-5d; Wed, 28 Jun 2023 15:06:28 +0200
Message-ID: <5ba6fadc-cdcc-0081-99f4-3b6f62f99a55@igalia.com>
Date:   Wed, 28 Jun 2023 10:07:05 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 0/9] btrfs: metadata_uuid refactors part1
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
References: <91368428-6950-3236-6bb2-13673527aaa9@igalia.com>
 <1a806c3f-4ddb-5f2a-becc-5ee1988c6d3f@oracle.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <1a806c3f-4ddb-5f2a-becc-5ee1988c6d3f@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/06/2023 05:52, Anand Jain wrote:
> 
> 
> I have a few items still in progress, and I should be sending
> them out this week. The main focus is on cleaning up the usage
> of the CHANGING_FSID flag. However, it also requires changes
> in the btrfs-progs and testing, which is taking longer than
> I anticipated. Thank you for your patience.
> 
> Thanks, - Anand
> 

Thanks Anand, no hurries at all. Was just in case you already had a
branch somewhere, I could pick it and work on top of that. But instead
I'm working now on top of "6.5-rc1", which already includes part 1.

It's good and I can fix conflicts later, not a biggie. Thanks for the
very useful refactor, I confess I found the metadata_uuid stuff a bit
confusing to read, code is now better =)

Cheers!
