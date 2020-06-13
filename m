Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB231F8120
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Jun 2020 07:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbgFMFi1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Jun 2020 01:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgFMFiZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Jun 2020 01:38:25 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CEEC03E96F
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Jun 2020 22:38:24 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id i3so8879553ljg.3
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Jun 2020 22:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=COZndSK6hsWAx892IzCN+TRfNLX3+kfebsAp7sCpN+g=;
        b=qnydtZ1J2bqwCmb5JoiqkBBHIntYCd37z+zbywYTVzrtJ/9Hyr+Vv3pU9uinbUaduH
         n4Pwo3o1I5K93+cTZ5mzYZn/SWPxv7VFWlK8AeeRX3fsrst+Cc0GtwCqHF44T5V4zp6Y
         zLw3ApGOshsH/E4AphfnOqwG+7ngXxlfMfHOpQ6OqZBWiwlUsyupYzZKCRAfDki4ojfZ
         k/wUnwRcfFfPBzeDHGBeZtjy066kXedWmPkF8r67YG6fbg7Y1TtwXCIS4hAR0PWaZmw2
         SD94Uwv+k8Gd8yoPVRY29O9HYgVx2JchPMH2FfIZQeXSh43pQXqrE8wMsvR7nnqvZA2+
         rZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=COZndSK6hsWAx892IzCN+TRfNLX3+kfebsAp7sCpN+g=;
        b=Lo2ZFNrtE+rxPOdbnWSAI7RAKWwMreCf/X6GHjRQcVLcp/WKV8X6y8CIOWVpDlxNn1
         lqJ7stWGdNYlouBHuSS/fRhNfRaubF14JGYGkDHeujw1eTU3DGhS1mJMmFYN/RIHT0OK
         k6/SnqCUaX2MHWGaT4t2N3Jt5XXT8k25PIKMcN8BtmB7kbh6sLGDJoCUa1onCjEI7UaT
         cN18nc9p9hmjDDXG7pgysVaDeg+749AVOWylQQrBiv1cdLksJdKFMGZHZKoZO0vl0Gl9
         oAWmVAFiYdugdYKXGTqjS/XteVuR4a66UgHcGAziFu9RZXYigMvdnHMLfp9i/hEWeO4g
         E6Bw==
X-Gm-Message-State: AOAM533vze6Skft1Nu4awrgaE/UqICnavDgjZ1Sn3O2+1lG8RvTo3knn
        2Yrz3o9KcRLYSFNWJn1ObVFtYEPi
X-Google-Smtp-Source: ABdhPJzm1/4IlJ8QybL8/KE6OJAbMRaRESRQ4vuskBFPqYLZfu63TXhZ/j7zyUDVkQdNrStKnlLDag==
X-Received: by 2002:a2e:b53b:: with SMTP id z27mr8556262ljm.173.1592026702575;
        Fri, 12 Jun 2020 22:38:22 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:2fcc:315b:7164:73a6:b557? ([2a00:1370:812d:2fcc:315b:7164:73a6:b557])
        by smtp.gmail.com with ESMTPSA id k12sm2360780lja.35.2020.06.12.22.38.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 22:38:21 -0700 (PDT)
Subject: Re: Does balancing also defragment data?
To:     Robbie Smith <zoqaeski@gmail.com>, linux-btrfs@vger.kernel.org
References: <CACurcBuLnsLKB1qgsOyU+W8TecZEnfoqnLziA6ynT95DEvNdDw@mail.gmail.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Autocrypt: addr=arvidjaar@gmail.com; prefer-encrypt=mutual; keydata=
 LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgptUUdpQkR4aVJ3d1JCQUMz
 Q045d2R3cFZFcVVHbVNvcUY4dFdWSVQ0UC9iTENTWkxraW5TWjJkcnNibEtwZEc3CngrZ3V4
 d3RzK0xnSThxamYvcTVMYWgxVHdPcXpEdmpIWUoxd2JCYXV4WjAzbkR6U0xVaEQ0TXMxSXNx
 bEl3eVQKTHVtUXM0dmNRZHZMeGpGc0c3MGFEZ2xnVVNCb2d0YUlFc2lZWlhsNFgwajNMOWZW
 c3R1ejQvd1h0d0NnMWNOLwp5di9lQkMwdGtjTTFuc0pYUXJDNUF5OEQvMWFBNXFQdGljTEJw
 bUVCeHFrZjBFTUh1enlyRmxxVncxdFVqWitFCnAyTE1sZW04bWFsUHZmZFpLRVo3MVcxYS9Y
 YlJuOEZFU09wMHRVYTVHd2RvRFhnRXAxQ0pVbitXTHVyUjBLUEQKZjAxRTRqL1BISEFvQUJn
 cnFjT1RjSVZvTnB2MmdOaUJ5U1ZzTkd6RlhUZVkvWWQ2dlFjbGtxakJZT05HTjNyOQpSOGJX
 QS8wWTFqNFhLNjFxam93UmszSXk4c0JnZ00zUG1tTlJVSllncm9lcnBjQXIyYnl6NndUc2Iz
 VTdPelVaCjFMbGdpc2s1UXVtMFJONzdtM0kzN0ZYbEloQ21TRVk3S1pWekdOVzNibHVnTEhj
 ZncvSHVDQjdSMXc1cWlMV0sKSzZlQ1FITCtCWndpVThoWDNkdFRxOWQ3V2hSVzVuc1ZQRWFQ
 cXVkUWZNU2kvVXgxa2JRbVFXNWtjbVY1SUVKdgpjbnBsYm10dmRpQThZWEoyYVdScVlXRnlR
 R2R0WVdsc0xtTnZiVDZJWUFRVEVRSUFJQVVDU1hzNk5RSWJBd1lMCkNRZ0hBd0lFRlFJSUF3
 UVdBZ01CQWg0QkFoZUFBQW9KRUVlaXpMcmFYZmVNTE9ZQW5qNG92cGthK21YTnpJbWUKWUNk
 NUxxVzV0bzhGQUo0dlA0SVcrSWM3ZVlYeENMTTcvem05WU1VVmJyUW5RVzVrY21WNUlFSnZj
 bnBsYm10dgpkaUE4WVhKMmFXUnFZV0Z5UUc1bGQyMWhhV3d1Y25VK2lGNEVFeEVDQUI0RkFr
 SXR5WkFDR3dNR0N3a0lCd01DCkF4VUNBd01XQWdFQ0hnRUNGNEFBQ2drUVI2TE11dHBkOTR4
 ajhnQ2VJbThlK2U0cXhETWpRRXhGYlVMNXdNaWkKWUQwQW9LbUlCUzVIRW9wL1R5UUpkTmc2
 U3Z6VmlQRGR0Q1JCYm1SeVpYa2dRbTl5ZW1WdWEyOTJJRHhoY25acApaR3BoWVhKQWJXRnBi
 QzV5ZFQ2SVhBUVRFUUlBSEFVQ1Bxems4QUliQXdRTEJ3TUNBeFVDQXdNV0FnRUNIZ0VDCkY0
 QUFDZ2tRUjZMTXV0cGQ5NHlEdFFDZ2k5NHJoQXdTMXFqK2ZhampiRE02QmlTN0Irc0FvSi9S
 RG1hN0tyQTEKbkllc2JuS29MY1FMYkpZbHRDUkJibVJ5WldvZ1FtOXljMlZ1YTI5M0lEeGhj
 blpwWkdwaFlYSkFiV0ZwYkM1eQpkVDZJVndRVEVRSUFGd1VDUEdKSERRVUxCd29EQkFNVkF3
 SURGZ0lCQWhlQUFBb0pFRWVpekxyYVhmZU1pcFlBCm9MblllRUJmOGNvV2lud3hUZThEVjBS
 T2J4N1NBS0RFamwzdFFxZEY3MGFQd0lPMmgvM0ZqczJjZnJRbVFXNWsKY21WcElFSnZjbnBs
 Ym10dmRpQThZWEoyYVdScVlXRnlRR2R0WVdsc0xtTnZiVDZJWlFRVEVRSUFKUUliQXdZTApD
 UWdIQXdJR0ZRZ0NDUW9MQkJZQ0F3RUNIZ0VDRjRBRkFsaVdBaVFDR1FFQUNna1FSNkxNdXRw
 ZDk0d0ZHd0NlCk51UW5NRHh2ZS9GbzNFdllJa0FPbit6RTIxY0FuUkNRVFhkMWhUZ2NSSGZw
 QXJFZC9SY2I1K1NjdVFFTkJEeGkKUnlRUUJBQ1F0TUUzM1VIZkZPQ0FwTGtpNGtMRnJJdzE1
 QTVhc3VhMTBqbTVJdCtoeHpJOWpEUjkvYk5FS0RUSwpTY2lIbk03YVJVZ2dMd1R0KzZDWGtN
 eThhbit0VnFHTC9NdkRjNC9SS0tsWnhqMzl4UDd3VlhkdDh5MWNpWTRaCnFxWmYzdG1tU045
 RGxMY1pKSU9UODJEYUpadXZyN1VKN3JMekJGYkFVaDR5UkthTm53QURCd1FBak52TXIvS0IK
 Y0dzVi9VdnhaU20vbWRwdlVQdGN3OXFtYnhDcnFGUW9CNlRtb1o3RjZ3cC9yTDNUa1E1VUVs
 UFJnc0cxMitEawo5R2dSaG5ueFRIQ0ZnTjFxVGlaTlg0WUlGcE5yZDBhdTNXL1hrbzc5TDBj
 NC80OXRlbjVPckZJL3BzeDUzZmhZCnZMWWZrSm5jNjJoOGhpTmVNNmtxWWEveDBCRWRkdTky
 Wkc2SVJnUVlFUUlBQmdVQ1BHSkhKQUFLQ1JCSG9zeTYKMmwzM2pNaGRBSjQ4UDdXRHZLTFFR
 NU1Lbm4yRC9USTMzN3VBL2dDZ241bW52bTRTQmN0YmhhU0JnY2tSbWdTeApmd1E9Cj1nWDEr
 Ci0tLS0tRU5EIFBHUCBQVUJMSUMgS0VZIEJMT0NLLS0tLS0K
Message-ID: <c118e64a-0e8d-3002-f880-89b960f94751@gmail.com>
Date:   Sat, 13 Jun 2020 08:38:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CACurcBuLnsLKB1qgsOyU+W8TecZEnfoqnLziA6ynT95DEvNdDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

13.06.2020 08:20, Robbie Smith пишет:
> This is something I've been wondering about lately. The defragmenting
> tool has known issues that break reflinks when run on files with lots
> of snapshots or copies, but balancing does not do this. The manual
> states that running a full balance without filters will basically
> rewrite the entire filesystem, so does it also defragment as it runs,
> or does it preserve the extents?
> 

No, it does not. Balancing moves extents while defragmenting rewrites
extents.
