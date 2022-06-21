Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8C25533A5
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jun 2022 15:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbiFUNe1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jun 2022 09:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351662AbiFUNbL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jun 2022 09:31:11 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453FA2496F
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jun 2022 06:29:17 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d5so12519793plo.12
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jun 2022 06:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=sHtMDpsookbIdFq5dPiO2I6RyptLYb8DAOh/oeJq4Hc=;
        b=L2KdIWFGbAdq5Hyf7YYJ2y96B1xjoNYadAnlXVeYI3IO6bjVNEUqPyB/00ABbmJyc6
         ICX9KgBVP21nM1l0mGGw6Of9hdG+Ffmxt50yhkCSaoNZymZySGihOSzTtLVs0klikpud
         6wCILK/+spgCqURBRZ1qQwPHHUdHIlo+UbWr31wRqzQVFn3gPbh3LXHtjI2pUYZL57M/
         eZdNXwYU+zyvoX/klGyPq1yfv9Mg70oPLdqZlUTFfBdTkQP1gDuuHLwPeR7alh4FY8Ws
         jtNUqLEUivOmTCVP8TTBpz8Uk3cwW5tGdwIqJAdZ3bYk8aXnPc4mo/xqHfnI8JjVftYX
         qQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=sHtMDpsookbIdFq5dPiO2I6RyptLYb8DAOh/oeJq4Hc=;
        b=7AuXgVbTOWv3gPBtQmL7qAZzcsO8vz5sw0kYw7ihcr+XGDEGq8pX/WiNaGu+CZYht6
         FKTw9UMc7Mh536Ngc9yrH3nmiRpR1wRT+uQzMV1OnipV4PME4crpYg8D1l06VU5EP/qP
         u6ARjFpspn8qhHEwZzf0Pe2TQW/Sb/TcWS3wkmXZlhTr58CK8KOitPcr+V/iSaW0JCCv
         SGbM3uvhqivN7cfJ4pqNcmql1j4j/aqds8ew4OTT0Q4lOLEjjx7tr6tiM90gWR3PHZ2y
         yZEUJBGbD4vQew1png9fNCOFXEDhTnWRkby86JV5xSbqIBJ1reEovAdDU4uW0HNgpMTu
         vA6Q==
X-Gm-Message-State: AJIora+cVQzuv76PvkjaWILTKgktmZrNMH9axSu94QfAj+2CwWhYCwzs
        /5DVpWQeX1brtb+cN287BJv+cFagiaw=
X-Google-Smtp-Source: AGRyM1uZ3guqbPXMYvdBd+HIWc9jFNLxe7PgBTAKzCRiFnin0QHFEzUNby+XqlNC/fcg29x5rSzrbQ==
X-Received: by 2002:a17:902:8f89:b0:168:d336:ddba with SMTP id z9-20020a1709028f8900b00168d336ddbamr29125839plo.1.1655818156627;
        Tue, 21 Jun 2022 06:29:16 -0700 (PDT)
Received: from [0.0.0.0] (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
        by smtp.gmail.com with ESMTPSA id e1-20020a170902784100b0016a35649186sm1812188pln.195.2022.06.21.06.29.15
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 06:29:16 -0700 (PDT)
Message-ID: <f5cc6c6f-2238-b126-3b0e-00e9e49b0706@gmail.com>
Date:   Tue, 21 Jun 2022 21:29:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     linux-btrfs@vger.kernel.org
From:   Zhang Boyang <zhangboyang.id@gmail.com>
Subject: [IDEA RFC] Forward error correction (FEC) / Error correction code
 (ECC) for BTRFS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I'm planning to implement error correction feature for btrfs, this 
feature can repair (limited) data corruptions on disk. Data corruptions 
can be caused by, for example, faulty disks, faulty RAMs, even cosmic 
rays. For RAID systems, the benefit of error correction feature is 
little because we store multiple copies of data, we can easily repair 
corrupted data using intact copies. But for single disk systems, or 
systems without ECC memory, this feature can be useful. The error 
correction feature can help user to repair their data when something bad 
happened.

The key idea is to reuse the space of checksums (ctree) to store error 
correction codes, (optionally) along with existing checksums.

Here are some detailed approaches:

1) Zero-cost approach 
======================================================

In fact it's not zero cost :) In this approach, the only requirement is 
to use a crypto hash as checksum in btrfs, e.g. SHA256 or BLAKE2b. So it 
also applies to existing btrfs instances. The error correction capacity 
is 1 byte. The error-correcting algorithm is brute-force, as below:

char data[N] = ...;  // data on disk, assume only one byte in it is 
corrupted
char csum[32] = ...; // checksum in ctree
for (int i = 0; i < N; i++) // brute-force error location
   for (int j = 0; j < 0x100; j++) { // brute-force byte value at location i
     char buf[N];
     memcpy(buf, data, N);
     buf[i] = j;
     if (checksum(buf) equals csum[]) {
       return SUCCESS; // data in buf[] are good data, repair succeeded
     }
   }
return FAIL; // search space exhausted, failed to repair

The computational cost of repairing is doing checksum of N bytes of 
data, N*255 times. As mkfs.btrfs requires nodesize < 65536, the maximum 
cost should approximately equal to checksum data of 1TB. For a typical 
4K sector, the cost is about checksumming 4GB data. This brute-force 
process can be easily parallelized, reducing the repair time. In fact, 
if one have infinite computing power, the error correction capacity can 
be enlarged, as long as the brute-force search space is significantly 
smaller than the checksum space.

Unfortunately, although I came up with this idea independently, a quick 
search on internet shows there is a US patent owned by Microsoft 
describes a very similar algorithm (Link: 
https://patents.google.com/patent/US9152502 ). I don't know if this 
trivial brute-force error-correcting algorithm may / may not affected by 
this patent. I'd like to hear opinions about this.


2) Low-cost approach: 
======================================================

In this approach, the checksum is generated by truncating a crypto hash 
to 32-T bytes and append T bytes (xv[T]) to that hash value. See the 
figure below:

   checksum = [-------CRYPTO-HASH-------][xv[0], xv[1], ...., xv[T-1]]
              <----- (32 - T) bytes ----><--------  T bytes --------->
              <--------------------- 32 bytes ----------------------->

The xv[i] is calculated by XORing data[j] where j%T==i, see the code below:

char data[N] = ...; // good data on disk
char xv[T];
memset(xv, 0, T);
for (int i = 0; i < N; i++)
   xv[i % T] ^= data[i];

Here is the example of T==8:
    let's view the data array d[] as (N/8) x 8 matrix:
        d[ 0], d[ 1], d[ 2], d[ 3], d[ 4], d[ 5], d[ 6], d[ 7],
        d[ 8], d[ 9], d[10], d[11], d[12], d[13], d[14], d[15],
        d[16], d[17], d[18], d[19], d[20], d[21], d[22], d[23],
   xor  d[24], d[25], d[26], d[27], d[28], d[29], d[30], ...
  ----------------------------------------------------------------
        xv[0], xv[1], xv[2], xv[3], xv[4], xv[5], xv[6], xv[7]
    then
        xv[0] = xor(column 0) = d[0]^d[8]^d[16]^d[24]^...
        xv[1] = xor(column 1) = d[1]^d[9]^d[17]^d[25]^...
        ...

This approach can correct at most T consecutive bytes. Formally, let 
d[i0], d[i1], d[i2], ..., d[iE] are corrupted bytes, then error 
correction can be done if and only if max(i0, i1, ..., iE) - min(i0, i1, 
.... iE) < T. The error-correcting algorithm is also brute-force, as below:

char data[N] = ...;  // data on disk, assume at most T consecutive bad bytes
char csum[32] = ...; // checksum in ctree, 32-T bytes hash and T bytes xv[]
char *xv = csum + 32 - T;
for (int i = 0; i <= N - T; i++) { // brute-force the begin of error 
location
   char buf[N];
   memcpy(buf, data, N);

   // calculate values in error location using xv[]
   char repair[T];
   memcpy(repair, xv, T);
   for (int j = 0; j < N; j++)
     if (j < i || j >= i + T)
       repair[j % T] ^= buf[j];
   for (int j = 0; j < T; j++)
     buf[i + j] = repair[(i + j) % T];

   if (checksum(buf)[0...32-T] equals csum[0...32-T]) {
     return SUCCESS; // data in buf[] are good data, repair succeeded
   }
}
return FAIL; // search space exhausted, failed to repair

Here is the example of above algorithm when T==8, i==11:
        d[ 0], d[ 1], d[ 2], d[ 3], d[ 4], d[ 5], d[ 6], d[ 7],
        d[ 8], d[ 9], d[10], ?????, ?????, ?????, ?????, ?????,
        ?????, ?????, ?????, d[19], d[20], d[21], d[22], d[23],
   xor  d[24], d[25], d[26], d[27], d[28], d[29], d[30], ...
  ----------------------------------------------------------------
        xv[0], xv[1], xv[2], xv[3], xv[4], xv[5], xv[6], xv[7]
    then
        d[11] = xv[3] ^ d[3]^d[19]^d[27]^...
        d[12] = xv[4] ^ d[4]^d[20]^d[28]^...
        ...

The computational cost of repairing is doing checksum of N bytes data, 
N-T+1 times. For nodesize < 65536, the maximum cost should approximately 
equal to checksum data of 4GB. For typical 4K sectors, cost is about 
checksumming 16MB data. Parallelizing is also possible.

If less then T bytes corrupts, this process can also speed up by 
skipping intact positions when brute-force searching. (If 
calc_xv(bad_data)[X] == xv[X], X < T, we can prove there is no 
corruption in column X, so we can skip checking for i%T==X while looping)

The value of T can't be too large. If T is too large, then the safety of 
32-T bytes hash will be too weak. Personally, I like T=8.

The process of calculating xv[] can SIMD easily. So there will be little 
cost when doing disk writes.

Unfortunately, since this algorithm use brute-force, it might be 
affected by the patent issue mentioned above. But I think even this 
algorithm is affected, we can save checksums with xv[] in btrfs, and 
create APIs for third party userspace tools to repair data externally.


3) Reed-Solomon approach: 
===================================================

Reed-Solomon (RS) can correct multiple symbol errors. Linux kernel 
already have support for RS codes (lib/reed_solomon). RS requires 
message size < 2**symsize. (message size = data size + parity size) For 
8-bit symbols (bytes), it requires message size < 255, which is not 
acceptable by btrfs. So we have to use 16 bit symbol size, then the 
limit is 65535 symbols = 131070 bytes.

If choose to generate T parity symbols (= 2*T parity bytes) for data, 
the RS can fix any combination of T/2 symbols corruption. Formally, let 
d[i0], d[i1], d[i2], ..., d[iE] are corrupted bytes, then error 
correction can be done if and only if set(floor(i0/2), floor(i1/2), ..., 
floor(iE/2)).size() <= T/2.

For example, if T == 6 (12 parity bytes), then
   * 3 error bytes at d[10], d[100], d[200] can be fixed
   * 4 error bytes at d[9], d[10], d[100], d[200] can NOT be fixed
   * 4 error bytes at d[10], d[11], d[100], d[200] can be fixed
   * 6 error bytes at d[10], d[11], d[100], d[101], d[200], d[201] can 
be fixed

However, using RS coder is very slow, because the complexity is 
O(N*T*T), and it make use of galois field arithmetic, which is slow. A 
simple test of T=6 only gives me 180MB/s on my machine.


Conclusion ===================================================

Personally I prefer approach 2 and 3. Since I'm new to kernel 
development, any comments or suggestions are welcome.


Best Regards,
Zhang Boyang
