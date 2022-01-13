Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3110E48D330
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jan 2022 08:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbiAMHuK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jan 2022 02:50:10 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:54944 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbiAMHuK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jan 2022 02:50:10 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 07CCF21138;
        Thu, 13 Jan 2022 07:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642060209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KRthSpmC+u5/Ygg6fmWBsVIAwD/ZRCNHcSbjCvkxlqY=;
        b=SHhoWyT+wdIUxYsYDYGdAPXTFKM2lhgsi8s59BZQjDzqQGaaVXFwygf2DwpL3ifUbJLlzp
        wM4bMhQmwnbDKEQN23QNE5Lbewks02XWjJJ3SR/nHLKUwpi/dtBMagVUiJQhnNIo+SBpDB
        HlzU/Ma6gYIkzerH5fnIN3gh/RBnj6g=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D001713E34;
        Thu, 13 Jan 2022 07:50:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kBLPL7DZ32EGPAAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 13 Jan 2022 07:50:08 +0000
Subject: Re: [PATCH v2] btrfs: cleanup finding rotating device
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <1b19262076d9ae10d3ff81f73209249375ae25bc.1642048893.git.anand.jain@oracle.com>
 <d56216c5f955862d31be7c9884222fa9b7a4ddbd.1642060052.git.anand.jain@oracle.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <901bd04b-dd20-4efc-ee46-b86b96dc0705@suse.com>
Date:   Thu, 13 Jan 2022 09:50:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <d56216c5f955862d31be7c9884222fa9b7a4ddbd.1642060052.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 13.01.22 г. 9:48, Anand Jain wrote:
> The pointer to struct request_queue is used only to get device type
> rotating or the non-rotating. So use it directly.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>


Reviewed-by: Nikolay Borisov <nborisov@suse.com>
