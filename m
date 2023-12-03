Return-Path: <linux-btrfs+bounces-544-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4EB802398
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Dec 2023 13:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2156EB20A45
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Dec 2023 12:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657AFC8F8;
	Sun,  3 Dec 2023 12:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPNdOITu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DEAEA
	for <linux-btrfs@vger.kernel.org>; Sun,  3 Dec 2023 04:05:07 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1fb38f3cb57so67551fac.3
        for <linux-btrfs@vger.kernel.org>; Sun, 03 Dec 2023 04:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701605105; x=1702209905; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mFff3JryC3tgxZ64PqqXWAGeC4MprmNogmrGUo62PhA=;
        b=NPNdOITutAF1iS2sVq+2MUtlCWlnUJ08QlK6ZhYW7nAM8RQvPIEXGH0MHEfHfmrXUY
         mPvlA+ZP6BHX8nxQ5r3mY2Z1rozfyVHd0N3xGZvikHfdhboQNucO9Jeld7ihWfNVFR4b
         rjbTzUMskJFhCZnXwsSYxC1zDBhh3DWXRkIoV00h4129Cx/ogwdXt+Cbu5oTI468X3Ah
         IKswTPAwGRIDdeRDJkRi0+4FUPN2wrlLBqXnnzXG2optOuyTG2U/u4E4oYVlYpK8hDRe
         Rz6uKxDCXy2iRmhnuWa4VcfzN0fMRFQhuE08JhqgzFgjFzFFEvkSy74uylw7tZ/CDFZm
         9iIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701605105; x=1702209905;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mFff3JryC3tgxZ64PqqXWAGeC4MprmNogmrGUo62PhA=;
        b=E2NwRp8O3ToU3YJ4jbHR1PKdPyyBQ5NRm9aQRNfhRz522HJhSiHrRertl5BDYijMWi
         GOr8EBOthhXL5b09EdQhQXveJFdzqLLEfd9ejvNC2+/MQuABMhQ9TyZ9wvINOBYZicqW
         B2Iu+71qEsvoPs5ZFxXJ0yYtsiXKmVqECUeC0dqUNtpQbSIih2HWYDaF8HMKQS+B/irv
         M1Bcl1ciT+CnEsBy/J7MVrhbh5tIthVC3l7xYmCrDUNqMesXj3JnYG+uAS8RS/TSjV3+
         WFkl/VtgbEMfk8GkPMTYVjrCtCnRzehmJJMbD9XsDwh1J+0gM4A/UInMNampOMhxYDkx
         kuBA==
X-Gm-Message-State: AOJu0YyEpxyJwhoEDDDUdaDOW0zx1UiTYAfYLxgUH5RfBfX3Z/e3kpco
	FXvpaATvmIVIJBECBxxf97w=
X-Google-Smtp-Source: AGHT+IE7rZrbeoFNvstcFGV2dCGOH5LHxkub+hrGD/kE8YnR2X/eeEZle5Yk3lAq/99aA8sEc5WUqQ==
X-Received: by 2002:a05:6870:5689:b0:1fa:bd89:799 with SMTP id p9-20020a056870568900b001fabd890799mr2282501oao.10.1701605105486;
        Sun, 03 Dec 2023 04:05:05 -0800 (PST)
Received: from ?IPV6:2600:6c56:7d00:582f::64e? ([2600:6c56:7d00:582f::64e])
        by smtp.googlemail.com with ESMTPSA id nd21-20020a056871441500b001fb2acf9a66sm551805oab.51.2023.12.03.04.05.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Dec 2023 04:05:04 -0800 (PST)
Message-ID: <39ff2b14-9f8a-4477-aa49-b4cb19e1d7ef@gmail.com>
Date: Sun, 3 Dec 2023 06:05:04 -0600
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BTRFS corruption after conversion to block group tree
Content-Language: en-US
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <eca4d15e-3ac7-4403-ba5b-a3148eb6b443@gmail.com>
 <e20c7d59-c460-4236-9771-9cb4a3f9dfb2@gmx.com>
 <1b32a750-d464-49f1-a288-577ee2fd473e@gmail.com>
 <bf4ee7ec-ab90-496c-9117-b13a096994a6@gmx.com>
 <3b55e499-791b-4f98-9ca3-0ff0a218c0bf@gmx.com>
 <8dac2b61-0a42-4416-9477-4cecc1b0eb06@gmail.com>
 <bae5e86b-d215-4984-95f2-4f24a8ee6bd9@gmx.com>
From: Russell Haley <yumpusamongus@gmail.com>
In-Reply-To: <bae5e86b-d215-4984-95f2-4f24a8ee6bd9@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/2/23 00:43, Qu Wenruo wrote:
> 
> Very hard to say if it's the firmware's fault, but it can also be our
> fault on the bg tree conversion.
> 
> Anyway two reports are more than enough for us to enhance bg tree
> conversion code.
> 

If the two reports you're counting are mine and Alexander's from October
that I linked at the top of the thread, make it three:

https://www.reddit.com/r/btrfs/comments/186pw3v/fs_got_corrupted_after_running_btrfstune/

