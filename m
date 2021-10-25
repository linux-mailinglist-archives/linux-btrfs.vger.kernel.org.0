Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E72438F99
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Oct 2021 08:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhJYGlN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Oct 2021 02:41:13 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51532 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhJYGlM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Oct 2021 02:41:12 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3D4CF2171F;
        Mon, 25 Oct 2021 06:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635143930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kEylrJRc/dvNVJywInVvlDq0pzvtKzuE66ZjsqXfCtk=;
        b=p41ZWBpD63aIKaSwk6ErfskF98LApKs40LPosDQtodszAn+1rKf+LQjpsL91Y1qYoJ+vn5
        xZ4/KRWwkk5INXxJTh0Fukk/pfBbjMXXrx6fQRWfAaW0GN0dYiBZtIKZhbKFAiqSoq/ckT
        R6VPZl4NqqGLfmueh0dlR71ovX0+MT8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0672813216;
        Mon, 25 Oct 2021 06:38:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id O67VOflQdmHBdAAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 25 Oct 2021 06:38:49 +0000
Subject: Re: [PATCH] btrfs-progs: remove path_cat[3]_out() double declaration
To:     kreijack@inwind.it, linux-btrfs <linux-btrfs@vger.kernel.org>
References: <3f86146a-d69c-e8c4-d3b4-d9c91d199d81@libero.it>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <090aee63-35dd-5a35-250d-8302f3806994@suse.com>
Date:   Mon, 25 Oct 2021 09:38:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <3f86146a-d69c-e8c4-d3b4-d9c91d199d81@libero.it>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 23.10.21 г. 19:40, Goffredo Baroncelli wrote:
> Remove the double declaration of path_cat_out()/path_cat3_out()
> 
> The functions
>   - path_cat_out()
>   - path_cat3_out()
> are declared two times in the following header files:
>   - common/path-utils.h
>   - common/send-utils.h
> 
> Remove the double declaration from send-utils.h and add the path-utils.h
> include file
> where needed.
> 
> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
