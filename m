Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2D3752A65
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 20:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjGMSmD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 14:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjGMSmC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 14:42:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666FE26B2
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 11:42:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2801D2211C;
        Thu, 13 Jul 2023 18:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689273720;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RwH9Ff/meQNtB7VVNH0axXz/2FUE8aQD/nhaNwukL0M=;
        b=WSwYaUw3N44sSn3ewlS9EmYGY//DrFpffOl1YEla6O5dNqPoScp4YYjrtgxVXKQ3sjaGtT
        MEe0ZPVh5s4Wyuin5UlxJaCUomQhzsJVKNGW+Zh+oMybVRzLQd1bzJOxB+W0e4rdVKWFsD
        FxWdOSS1O+xBamOIhEqCMXx3C8VSOqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689273720;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RwH9Ff/meQNtB7VVNH0axXz/2FUE8aQD/nhaNwukL0M=;
        b=9crYXGhryjbn5je1HLWiTk7tGR90idgU4h1eqTIP9Me/fX30jBm6DkVNA2y2omp5CBPCkR
        tIK9mMyvYj164YDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EF90513489;
        Thu, 13 Jul 2023 18:41:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4AV4OHdFsGQ4fwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 13 Jul 2023 18:41:59 +0000
Date:   Thu, 13 Jul 2023 20:35:23 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/10] btrfs-progs: check and tune: add device and noscan
 options
Message-ID: <20230713183523.GZ30916@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1687943122.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687943122.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 28, 2023 at 07:56:07PM +0800, Anand Jain wrote:
> By default, btrfstune and btrfs check scans all and only the block devices
> in the system.
> 
> To scan regular files without mapping them to a loop device, adds the
> --device option.
> 
> To indicate not to scan the system for other devices, adds the --noscan
> option.
> 
> For example:
> 
>   The command below will scan both regular files and the devices
>   provided in the --device option, along with the system block devices.
> 
>         btrfstune -m --device /tdev/td1,/tdev/td2 /tdev/td3
>   or
>         btrfs check --device /tdev/td1 --device /tdev/td2 /tdev/td3
> 
>   In some cases, if you need to avoid the default system scan for the
>   block device, you can use the --noscan option.
> 
>         btrfstune -m --noscan --device /tdev/td1,/tdev/td2 /tdev/td3
> 
>         btrfs check --noscan --device /tdev/td1,/tdev/td2 /tdev/td3

From the examples above I don't understand which devices get scanned or
not, there are the --device ones and then the agtument. Also for
examples please use something recognizable like /dev/sdx, /dev/sdy,
otherwise it looks like it requires some special type of device.

I'd expect that --noscan will not scan any device that is part of the
filesystem that is pointed to by the agrument (/tdev/td3 in this case).

If the option --noscan + --device are meant to work together that only
the given devices are either scanned or not (this is the part I don't
see clearly), then I'd suggest to let --noscan take a value of device
that won't be scanned.

Eventually there could be a special value --noscan=all to not scan all
devices. Also please drop the syntax where the devices are separated by
",", one option per device should work for everybody and you can avoid
parsting the option value.
