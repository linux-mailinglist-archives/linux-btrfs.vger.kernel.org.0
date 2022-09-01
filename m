Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1295A99AA
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Sep 2022 16:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbiIAODz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 10:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234533AbiIAODn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 10:03:43 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B8C2185
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 07:03:42 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id b9so13279785qka.2
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Sep 2022 07:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=KGfTB5nKMSj//UvzrjNrwttu4w9cMzhzu5aRXAUo8sA=;
        b=jZ/rQvG8hqDtYxYV/40XMczJ4TCOxJnjwEDNrQz55Zp6x97BqAl7Ja+q+T4Ajn6n3E
         Fn9EGCx9hwE38HOF5l1iSrEf9VTRQiDjomDQL+dcEfjGJgAS3vWPAlRFkuU/ypQF+z4Y
         eH/GvVXZyKmgsnKbDmGCbxFpGoBlpOebECsPNcSgVxv+QdQDi+zeTjaOEBczD1l3nPpF
         1//ldTFjr3Qb7XjIkYTN4cfPmxpAMJYrVPSKeqRdOmEM/W3JuJAUJB194/aBa084t9MA
         UDlXwpf4mkPcNETBpKYIiggDeTkr5n1wul6kfqQ2jMLa3ORckIojAbb3amz9iPmBO0Ig
         V1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=KGfTB5nKMSj//UvzrjNrwttu4w9cMzhzu5aRXAUo8sA=;
        b=7uC8WWt3Ka5JbG5FmaSZFS3GHcy/MMc05tF0MmGnPjw70BHFdiGKrIZChLFvm3sR3P
         Ps98oVEBocauR7CiI9bSTE2abYfKLT1G6L5r6BKpauo689TS34a1Ex1yXBpotVfotfVv
         IISHkBb2MnPA3ybae8KjG6aXnNcXxW4VEPy1mFdKV3UnyU6pGiW9GJ+uD+N4qFDJlPGX
         5BwjEUhNqgeeR2TImp+PlWTOKazgxWv4CnXtL2k8IeV+lUy+ElB8ZImbwC69O6PjiC1U
         QXBGeuKeEyKDIEUlx848qQoV3UnpI/ADk61v9Yo63RZNv+Q7x+rC4DcGKRtJIZjhm65j
         +7rA==
X-Gm-Message-State: ACgBeo3jv6uI8UxBRpKYV7b1CvmVLwGBGoAL4c1AFb7rCC/D5c9pe1ov
        GtJzU+R8WmnA8Wrsdx3X52Bu6Q==
X-Google-Smtp-Source: AA6agR6FYTAlSqI5AiSa92cIbKIcqIzrj9Z4+e5mm+AXjMvdgiivCJqBbxXp4lUhbdO0MoF6ziGRJA==
X-Received: by 2002:a05:620a:4155:b0:6bb:7eba:3ff8 with SMTP id k21-20020a05620a415500b006bb7eba3ff8mr19443350qko.188.1662041021137;
        Thu, 01 Sep 2022 07:03:41 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id ay6-20020a05620a178600b006b59f02224asm11436577qkb.60.2022.09.01.07.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 07:03:40 -0700 (PDT)
Date:   Thu, 1 Sep 2022 10:03:39 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 03/10] btrfs: remove check for impossible block start for
 an extent map at fiemap
Message-ID: <YxC7u2NYbz5quLMX@localhost.localdomain>
References: <cover.1662022922.git.fdmanana@suse.com>
 <a33ca7029931ae0a076cfe0a151881bd43016472.1662022922.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a33ca7029931ae0a076cfe0a151881bd43016472.1662022922.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 01, 2022 at 02:18:23PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> During fiemap we are testing if an extent map has a block start with a
> value of EXTENT_MAP_LAST_BYTE, but that is never set on an extent map,
> and never was according to git history. So remove that useless check.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
