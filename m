Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D80432F79
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Oct 2021 09:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbhJSHca (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Oct 2021 03:32:30 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53996 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234564AbhJSHcX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Oct 2021 03:32:23 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E7E422197A;
        Tue, 19 Oct 2021 07:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634628610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YX5TWSHlgafwBXronoCKb9ZrQvPvDCutU5RW/aFVz5Q=;
        b=ii4ZB433ma8hPq7cYaMwPl0oba1if4BhszyvzhskA/7VL+390StOa7k0wLJWvoGqBMVe3R
        wmk6xB4RNPMeKzkOUfQY79niaBO4uvXWhMEnEpaiJBwTmE5lELpl9Rm3eceIvlJol0FkSS
        2L2XOMYFsx31qck/Bvth9Q1yf0sGdng=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A45E513CEE;
        Tue, 19 Oct 2021 07:30:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pmV9JQJ0bmFCcQAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 19 Oct 2021 07:30:10 +0000
Subject: Re: [PATCH RFC] btrfs: send: v2 protocol and example OTIME changes
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     osandov@osandov.com
References: <20211018144109.18442-1-dsterba@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <1e8eb20b-f6cb-6a68-ac9f-6d8eb85b4f1d@suse.com>
Date:   Tue, 19 Oct 2021 10:30:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211018144109.18442-1-dsterba@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 18.10.21 г. 17:41, David Sterba wrote:
> This is send protocol update to version 2 with example new commands.
> 
> We have many pending protocol update requests but still don't have the
> basic protocol rev in place, the first thing that must happen is to do
> the actual versioning support. In order to have something to test,
> there's an extended and a new command, that should be otherwise harmless
> and nobody should depend on it. This should be enough to validate the
> non-protocol changes and backward compatibility before we do the big
> protocol update.
> 
> The protocol version is u32 and is a new member in the send ioctl
> struct. Validity of the version field is backed by a new flag bit. Old
> kernels would fail when a higher version is requested. Version protocol
> 0 will pick the highest supported version, BTRFS_SEND_STREAM_VERSION,
> that's also exported in sysfs.
> 

W.r.t to the bits which add the infrastructure to do versioned support
you have an ACK from me. In the final submission I'd like to see those
bits separate from the rest of the code which implements particular
protocol changes, once this lands then Omar can also base his code on
the added infrastructure.
