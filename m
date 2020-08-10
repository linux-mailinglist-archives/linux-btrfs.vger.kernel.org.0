Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC062240311
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Aug 2020 10:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbgHJIAC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Aug 2020 04:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgHJIAB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Aug 2020 04:00:01 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284D7C061756
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 01:00:00 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 2so7529262qkf.10
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 01:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dallalba.com.ar; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=82sjQUbcfk5ctAnP3uTWOUb7+pCpQ5spWjPDQDrw9ns=;
        b=NalUaXqdAP45lTr9CR76mlze68ZT9FR6waUktlwRMYXb7GcaZTJena0PBYpWuvIf+V
         T4zNZ9pyoKRpid3zsgkq8AS01/2UXNxR4qxVAMN+DGadtDegXS9OMXz+ZT4TXpga0L94
         rwgVAO3/DOXEoJ7q1qtobZu5b1JVGRFgJZ8qM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=82sjQUbcfk5ctAnP3uTWOUb7+pCpQ5spWjPDQDrw9ns=;
        b=UqV5XGwhJgylMX4IVZK838X4uvVBm236vLY+LKmNRlzDmJl5U2JQ36ivE4F8MCztKf
         lu9Is6UFR7V24UFMt7JI2YOtnVdcI58RKz240XHDFKezs3K0QG15QQetM+CZNgn+h/S3
         wxtPazlUT7koSb7z/t2jU7WQ/SWOW5JVo1c0hUiIyugZAL8hGyHkQ1YQ1eH/59c/NJOM
         UcVmJkZHl/2Ek0MkxRh/I3EMwv2i3Y14GlTuRZtfM22kTHLfHHBcib696Q65OWIpgtLe
         j/9Uu7YwMlMfgGy5QUSJzrMHBFixozxkunZGQGBdna9O7CCYeEXSfC8kyc/pNSuA2L65
         0awg==
X-Gm-Message-State: AOAM53304Pt7HN16VeqolZnM3KLncmxVnj4ASseUJ2aRg2Z4dSHar+NA
        nIWyDoGKtEOn0wxk7MjfqHntl9ayzg==
X-Google-Smtp-Source: ABdhPJzeAtVxcleqMSK+eBtFr1bwjZQQ/3VBpR5ks/ZSxEm5bC3jQeBFdTYNc693aoxS60geNInzUQ==
X-Received: by 2002:a05:620a:10ab:: with SMTP id h11mr24051120qkk.219.1597046399643;
        Mon, 10 Aug 2020 00:59:59 -0700 (PDT)
Received: from atomica ([2803:9800:a011:8d29:a588:5e7f:26f:986])
        by smtp.gmail.com with ESMTPSA id m203sm13258406qke.114.2020.08.10.00.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 00:59:59 -0700 (PDT)
Message-ID: <75b06c6a26cf64bd9d2eeb76bf81ea698126257e.camel@dallalba.com.ar>
Subject: Re: raid10 corruption while removing failing disk
From:   =?UTF-8?Q?Agust=C3=ADn_Dall=CA=BCAlba?= <agustin@dallalba.com.ar>
To:     Martin Steigerwald <martin@lichtvoll.de>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Date:   Mon, 10 Aug 2020 04:59:57 -0300
In-Reply-To: <16328609.DpnNoz7ane@merkaba>
References: <3dc4d28e81b3336311c979bda35ceb87b9645606.camel@dallalba.com.ar>
         <ac06df32-0c18-c17c-64c9-45a04fc82057@suse.com>
         <16328609.DpnNoz7ane@merkaba>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 2020-08-10 at 09:38 +0200, Martin Steigerwald wrote:
> I have no idea why Ubuntu opted to use a non LTS kernel – especially as 
> 4.15 is pretty old and so does not sound to come from a supported Ubuntu 
> release unless it is some Ubuntu LTS release, but then I'd expect a LTS 
> kernel to be used –, but "-111" indicates they added a lot of patches by 
> now. So maybe they provide some kind of LTS support themselves.

It is indeed the kernel of the 18.04 LTS Ubuntu release.

On Mon, 2020-08-10 at 10:22 +0300, Nikolay Borisov wrote:
> This is a vendor kernel so you should ideally seek support through the
> vendor. This kernel is not even an LTS so it's not entirely clear which
> patches have/have not been backported. With btrfs it's advisable too use
> the latest stable kernel as each release brings bug fixes or at the very
> least (because always using the latest is not feasible) at least stick
> to a supported long-term stable kernel  - i.e 4.14, 4.19 or 5.4
> (preferably 5.4)

Would it help to run a mainline kernel and report again, or is it 'too
late' for this filesystem? If so, should I use 5.4.57 or go straight to
5.8? For now I have forwarded my question to the Ubuntu kernel team
mailing list.

Kind regards.

