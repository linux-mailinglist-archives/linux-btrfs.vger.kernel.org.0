Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD7C6D79DC
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Apr 2023 12:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237666AbjDEKhn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Apr 2023 06:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237654AbjDEKhl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Apr 2023 06:37:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76254C17
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Apr 2023 03:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680691009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8hFqrvNZsn86teCYjqs2wVJUMFZmHeavzTexdU+dVHw=;
        b=NAiLEzl10qFt6snaAQP2hfdhzRimdNsv7/DkZBn8NFMYda9ZexlvVrZGs+9B0if20NZrKh
        E0yElc4xN57N/sbHyTaGfEFctOyq8UsNrQwKzUmcQ7eUBRF+s+aIEBDaCADydrCsQnBwJv
        o3lOFa56cwTQ1qunAmDJTtWIYr7HpzE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-GAc_CVLdMtensehpoHExng-1; Wed, 05 Apr 2023 06:36:48 -0400
X-MC-Unique: GAc_CVLdMtensehpoHExng-1
Received: by mail-qt1-f197.google.com with SMTP id h6-20020ac85846000000b003e3c23d562aso24084283qth.1
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Apr 2023 03:36:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680691008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hFqrvNZsn86teCYjqs2wVJUMFZmHeavzTexdU+dVHw=;
        b=oQ0UyBpN+rVeSXuAIyztqE5ZoJ31V6+Z+WofuUK3+8C4NGku7rZ1ctTJsFpzF4skNn
         X5+DSt3xAB5k2q2efKVGke8WB2akps1QpF8mgjWKyKPSFNyB/6+tGWs/ZC6aZhQkqr2g
         4u122Co9drbCfuwWdarxvAvDeXsbKZDGJSwyaFaAfjhwa2YAykYBS6iHyrzh2YBMSnMB
         iS50VwQvw+JT294Q0jEsvob82s9DfphTvtm6fT5Gps2/8TbedexX7UPi608l9UYkHGdU
         P8nwoLOrCkXhLBdEZ22Nm1caEgrVg3anpnFiCDPnV2+kYgNlwgsL4zUl0weCzBut9v2s
         0Dqg==
X-Gm-Message-State: AAQBX9cJhpNUDdaXFWTZFH0WLoZgaRO/P22bex4F3V3LkN+sqq8YIbyB
        5viWTRyutITkMiMkqXcKcp+Z5Z6UUa+o3j8A5kyrh21+IHd32ksJEaEQVRmCitxBBBY5qZou+rh
        ndg6wQEztp5b2742tf7YIEw==
X-Received: by 2002:a05:622a:181c:b0:3da:aa9b:105a with SMTP id t28-20020a05622a181c00b003daaa9b105amr4016625qtc.17.1680691008080;
        Wed, 05 Apr 2023 03:36:48 -0700 (PDT)
X-Google-Smtp-Source: AKy350Yray4mqL/DA63FufP2W8G+Q2vCv/dEYqnAM/OkHjKwnv430c/AiUDk3FXiS3P6h8ilen17Eg==
X-Received: by 2002:a05:622a:181c:b0:3da:aa9b:105a with SMTP id t28-20020a05622a181c00b003daaa9b105amr4016592qtc.17.1680691007736;
        Wed, 05 Apr 2023 03:36:47 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id i2-20020ac84882000000b003d5aae2182dsm3911845qtq.29.2023.04.05.03.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 03:36:47 -0700 (PDT)
Date:   Wed, 5 Apr 2023 12:36:42 +0200
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     djwong@kernel.org, dchinner@redhat.com, ebiggers@kernel.org,
        linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
        rpeterso@redhat.com, agruenba@redhat.com, xiang@kernel.org,
        chao@kernel.org, damien.lemoal@opensource.wdc.com, jth@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com
Subject: Re: [PATCH v2 05/23] fsverity: make fsverity_verify_folio() accept
 folio's offset and size
Message-ID: <20230405103642.ykmgjgb7yi7htphf@aalbersh.remote.csb>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-6-aalbersh@redhat.com>
 <ZCxCnC2lM9N9qtCc@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCxCnC2lM9N9qtCc@infradead.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Christoph,

On Tue, Apr 04, 2023 at 08:30:36AM -0700, Christoph Hellwig wrote:
> On Tue, Apr 04, 2023 at 04:53:01PM +0200, Andrey Albershteyn wrote:
> > Not the whole folio always need to be verified by fs-verity (e.g.
> > with 1k blocks). Use passed folio's offset and size.
> 
> Why can't those callers just call fsverity_verify_blocks directly?
> 

They can. Calling _verify_folio with explicit offset; size appeared
more clear to me. But I'm ok with dropping this patch to have full
folio verify function.

-- 
- Andrey

