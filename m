Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593381D1ABA
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 May 2020 18:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389220AbgEMQMB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 May 2020 12:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388714AbgEMQMB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 May 2020 12:12:01 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD721C061A0C
        for <linux-btrfs@vger.kernel.org>; Wed, 13 May 2020 09:12:00 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id e25so214232ljg.5
        for <linux-btrfs@vger.kernel.org>; Wed, 13 May 2020 09:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LC2bVa3aSHp2EVBkCgZoxOM8WHGFh1Zt5TDBnygcANQ=;
        b=sqDWyB1J0ZnlFgZJ9f/Kh5GO6shkfAQc7bBFPMAb7Kul4g/dYdm4G4ae1DaIYhoxpI
         vSqdrGSP6f4aScSZXE18MzLtFk9S/LxJPjeUZjLYHHxpP5D868fza/7uzFeCh20E6Lh+
         U/OGH9f5Aj7tzPQfeoql4i0O/XxlgbCXocY/0559jgdF/cwybLSaJ7+wEnm3JEfDqpfb
         vxc1rvQc9HqtZPNH1rrpKCctvnSH0HrUVwhV147p5aoqxSO6pRGCy+N9dnjxpqpAcK/v
         3kGPpHWmBy92hFPjg0j9DVrij5C/wrI3Nxxyv9Gjz8tpCU30O5gX3cET3gS8GMfAeMdV
         o2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LC2bVa3aSHp2EVBkCgZoxOM8WHGFh1Zt5TDBnygcANQ=;
        b=QE1zOoxtGu23BwvLxypgdKkd3rnRy2uEYB0Ptn0rQxrW/sCW6b085MUxkWv8KIFfqm
         dD6aQtCntP9D6Dx5kH93C5EyoNGj0YyBgWCufgAdls1KdSmM1Ddz8ZqpQijRq+Uuj7tL
         HVgIdNMBWA10tA9iRZdaNeoaLjqqumKKhomAx5KznE5UmYyq1LYWb8e9Y0G7pkohwzs8
         58JZoi0QeECT5kA6yuWyScXuFl8D5yZHL+jQ9TPa5Mvg3VfwLB6/os/NrIJNaSrfIobS
         Gi262fpGNCwpbw5sWAOiqX3jY6SxYsF4KJe0ZS5unUEJSKEHOjaVENZHBqUCuo60GTs7
         ABVw==
X-Gm-Message-State: AOAM5315kpffnrpXMEq7Pg468RHxdlkSe6cM1WD5plaMGrGtPqL7C76l
        mlAMGLLURI3KeR1qMMzDnVa80hHF
X-Google-Smtp-Source: ABdhPJxYhP+mbGLxoHjz9nwTvdisWihTqty4idxCm218Mr5RUBRkku9CElpY42vhZypBRTT8JzB/aA==
X-Received: by 2002:a2e:87d0:: with SMTP id v16mr16870134ljj.137.1589386317843;
        Wed, 13 May 2020 09:11:57 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:6b65:ffac:bd33:4d59:de4a? ([2a00:1370:812d:6b65:ffac:bd33:4d59:de4a])
        by smtp.gmail.com with ESMTPSA id y76sm61199lff.45.2020.05.13.09.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 09:11:56 -0700 (PDT)
Subject: Re: Error when using btrfs subvolume snapshot & send | receive
To:     =?UTF-8?Q?Ren=c3=a9_Fricke-M=c3=bcller?= <rene.fricke94@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <57021127-01ea-6533-6de6-56c4f22c4a5b@gmail.com>
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
Message-ID: <fa8e7847-8603-1f50-a105-af7989dd5f0e@gmail.com>
Date:   Wed, 13 May 2020 19:11:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <57021127-01ea-6533-6de6-56c4f22c4a5b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

13.05.2020 15:16, René Fricke-Müller пишет:
> Hello,
> 
> I have some trouble using btrfs snapshots on Ubuntu 19.10.
> 
> I am creating snapshots of my /-subvolume and use send | receive for
> incremental transferring. Sometimes I get errors like "ERROR: cannot
> open /media/Backup/OS/snapshots/snap_2020-05-13_11:39/o13170-19818-0: No
> such file or directory"
> 

You did not say whether error is on source or destination side.

> When I look deeper with the -v option, it seems like btrfs is creating a
> folder or something, moves it and then tries to rename the original folder.
> 


Still unclear whether it is send or receive.

> The error occures on different devices, but only when I make snapshots
> of the root of my os subvolume. The error occures only from time to time
> (perhaps every 5th to 15th snapshot) the only solution to send a new
> snapshot complete and then send incremental snapshots.
> 
> I tried different kernels:
> Currently I am using 5.3.0-51-generic on one device but also tried 5.5
> and 5.6.11.
> 
> I found this topic on github, where some people have the same errors.
> (but I am using an own script, not that program)
> 
> https://github.com/digint/btrbk/issues/223
> <https://github.com/digint/btrbk/issues/223>
> 

This describes error on destination. Such errors are indications that
btrfs finds wrong base snapshot to apply changes to. Does your source
subvolume has received UUID by any chance?

Output of

btrfs subvolume show <source>
btrfs subvolume show <target>

would be interesting.

> 
> Can you confirm this error and/or help me?
> 
> 
> Kind Regards
> 
> René

