Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0019D7DFB3E
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Nov 2023 21:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjKBUHs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Nov 2023 16:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjKBUHr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Nov 2023 16:07:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AA0186;
        Thu,  2 Nov 2023 13:07:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7B0101F8D4;
        Thu,  2 Nov 2023 20:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698955659;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P4bCMfteguYoKji2FI9q8fru+pHSFOE8fwUffQBFniQ=;
        b=D39+iQ7G+ztxbdRfOC6lKk7nz8AMDy32p0cHU+3aQVwCbKhvTuCOMb0yIHCdfGwHqGZLeO
        VA+g5qcvTVEFqKFi6ZsLDYHymkp0yVYLLS5RqAyVQYMzsDzJDEVz18HR80BwisUlKvVhrd
        SANQ6VbjK6X0OzjFe+jHDpDUJlYyBeI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698955659;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P4bCMfteguYoKji2FI9q8fru+pHSFOE8fwUffQBFniQ=;
        b=rapx8VCopt/VKBGp2VgoT5x8fU/oEZHcAY7QZuwbxqwJGUajefZ7yfppyhxaRKNneOleFb
        nyjfidXQTvvYxzBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4B51713584;
        Thu,  2 Nov 2023 20:07:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SjXDEYsBRGVsMAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 02 Nov 2023 20:07:39 +0000
Date:   Thu, 2 Nov 2023 21:00:40 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org, zlang@redhat.com
Subject: Re: [PATCH v4 1/5] common/rc: _fs_sysfs_dname fetch fsid using btrfs
 tool
Message-ID: <20231102200040.GH11264@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1698712764.git.anand.jain@oracle.com>
 <d63c4427d1dc9db3c18a07cb9098459de242fbd3.1698712764.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d63c4427d1dc9db3c18a07cb9098459de242fbd3.1698712764.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 02, 2023 at 07:28:18PM +0800, Anand Jain wrote:
> Currently _fs_sysfs_dname gets fsid from the findmnt command however
> this command provides the metadata_uuid if the device is mounted with
> temp-fsid. So instead, use btrfs filesystem show command to know the fsid.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> ---
> v3: add local variable fsid
> 
>  common/rc | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 259a1ffb09b9..7f14c19ca89e 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4721,6 +4721,7 @@ _require_statx()
>  _fs_sysfs_dname()
>  {
>  	local dev=$1
> +	local fsid
>  
>  	if [ ! -b "$dev" ]; then
>  		_fail "Usage: _fs_sysfs_dname <mounted_device>"
> @@ -4728,7 +4729,9 @@ _fs_sysfs_dname()
>  
>  	case "$FSTYP" in
>  	btrfs)
> -		findmnt -n -o UUID ${dev} ;;
> +		fsid=$($BTRFS_UTIL_PROG filesystem show ${dev} | grep uuid: | \
> +							$AWK_PROG '{print $NF}')

This could be also added as a subcommand to 'inspect-internal', ie. from
a file to it's filesystem uuid, then it should be easy to get any other
id if needed through the sysfs directory.
