Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D364434AC
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Nov 2021 18:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbhKBRmQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Nov 2021 13:42:16 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36434 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbhKBRmO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Nov 2021 13:42:14 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E0F95212B8;
        Tue,  2 Nov 2021 17:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635874777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qTAPescKnC+rR6GSQmNXDgFDXQo1qZT2sE337LU7Rlk=;
        b=BRPcNRSJmfYoCwaDudBLu+btrx5HIQl0Rf370wY7hRrrrPg38PT+u5/orjIzYf4cfop84Z
        QRlLIA8Ezl2dmy1LzEwePMdUcHq6qX2aEPT6k6w3PSq66g51ZiFh8PQuEdfA1lxOE4Kqk8
        ExOmfKFmBpyaPEEdywSOKqpg2tsF0eA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A17D713C3D;
        Tue,  2 Nov 2021 17:39:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7u/OJNl3gWEcDwAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 02 Nov 2021 17:39:37 +0000
Subject: Re: [PATCH 0/3] Balance vs device add fixes
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
References: <20211101115324.374076-1-nborisov@suse.com>
 <YYFLlL4NTF4L+PmE@localhost.localdomain>
 <516c7eaf-3fb2-fe61-08f8-ac4201752121@suse.com>
 <20211102172528.se6voh75geqjjltf@zuko>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <541927b1-ff40-4d5a-6d99-709b10e4c141@suse.com>
Date:   Tue, 2 Nov 2021 19:39:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211102172528.se6voh75geqjjltf@zuko>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2.11.21 г. 19:25, Goldwyn Rodrigues wrote:
> But do we really need to use *_ONCE, assuming btrfs_exclusive_operation
> fits in 8 bits?
> 


The way I understand it based on the LWN articles is that the effect of
_ONCE is twofold:

1. It prevents theoretical torn writes + forces the compiler to always
issue the access i.e prevent it being optimized out - this could be moot
in our case.

2. It serves a documentation purpose where it states "this variable is
accessed in multithreaded contexts, possibly without an explicit lock" -
and this IMO is quite helpful in this particular context.
